SHELL := bash -e

.PHONY: tidy
tidy:
	$(info Tidying up...)
	find gen api -name 'go.mod' | xargs dirname | xargs -I '{}' go -C '{}' mod tidy
	go work sync

.PHONY: gen
gen:
	make clean
	buf generate proto

.PHONY: clean
clean:
	find gen/go -type d -depth 1 | xargs rm -rf
