.PHONY: help test test-env

# Cookiecutter configurations to test
ALL_CONFIGS=base.yaml \
			minimal.yaml
# Default project name selected by the cookiecutter template
PROJECT_NAME:=my-jupyter-stack
# Shell that make should use
SHELL:=bash

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test/%:
	cookiecutter --no-input --config-file configs/$(notdir $@) -f -o /tmp .
	make -C /tmp/$(PROJECT_NAME) build test-env test

test: $(ALL_CONFIGS:%=test/%) ## Make projects and runs their tests

test-env: ## Make a test environment by installing test dependencies with pip
	pip install -r requirements-test.txt