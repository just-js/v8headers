.PHONY: help clean

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_\.-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

deps: ## download the v8lib repo and extract just the headers
	rm -fr deps
	curl -L -o v8lib-current.tar.gz https://github.com/just-js/libv8/archive/current.tar.gz
	tar -zxvf v8lib-current.tar.gz
	tar -zxvf libv8-current/v8.tar.gz
	rm deps/v8/libv8_monolith.a

dist: deps ## make distribution tarball
	rm -f v8.tar.gz
	tar -cv deps | gzip --best > v8.tar.gz

clean: ## clean
	rm -fr libv8-current
	rm -f v8lib-current.tar.gz
	rm -fr deps

all: ## make all the things
	make clean
	make v8headers
	make dist

.DEFAULT_GOAL := help
