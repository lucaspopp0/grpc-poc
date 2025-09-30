SHELL := bash -e

.PHONY: tidy
tidy:
	$(info Tidying up...)
	find . -name 'go.mod' | xargs dirname | xargs -I '{}' go -C '{}' mod tidy
	go work sync

.PHONY: gen
gen:
	make clean
	buf generate proto

.PHONY: clean
clean:
	find gen/go -type d -depth 1 | xargs rm -rf

.PHONY: docker-build
docker-build: tidy
	GOOS=linux CGO_ENABLED=0 go -C server build -tags netgo -o ../server-linux
	DOCKER_BUILDKIT=1 docker build --quiet --tag lucaspopp0/grpc-poc:latest .

.PHONY: docker-run
docker-run: docker-build
	docker compose up
