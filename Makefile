SHELL := bash -e

.PHONY: tidy
tidy:
	$(info Tidying up...)
	find . -name 'go.mod' | xargs dirname | xargs -I '{}' go -C '{}' mod tidy
	go work sync

.PHONY: install-tools
install-tools:
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
	@go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest

.PHONY: gen
gen:
	make install-tools

	find gen/go -type d -depth 1 | xargs rm -rf
	rm -rf gen/openapi
	mkdir -p gen/go gen/openapi

	@if [ ! -d "third_party/googleapis" ]; then \
		echo "Downloading googleapis..."; \
		mkdir -p third_party; \
		git clone --depth 1 https://github.com/googleapis/googleapis.git third_party/googleapis; \
	fi

	@echo "Running protoc..." && \
	protoc -I proto \
		-I third_party/googleapis \
		--go_out=gen/go --go_opt=paths=source_relative \
		--go-grpc_out=gen/go --go-grpc_opt=paths=source_relative \
		--grpc-gateway_out=gen/go --grpc-gateway_opt=paths=source_relative \
		--openapiv2_out=gen/openapi --openapiv2_opt=allow_merge=true,merge_file_name=api \
		proto/**/*.proto

	rm -rf third_party

	go run ./server/openapi2to3/main.go && rm gen/openapi/api.swagger.json

.PHONY: docker-build
docker-build: tidy
	GOOS=linux CGO_ENABLED=0 go -C server build -tags netgo -o ../server-linux
	DOCKER_BUILDKIT=1 docker build --quiet --tag lucaspopp0/grpc-poc:latest .

.PHONY: docker-run
docker-run: docker-build
	docker compose up
