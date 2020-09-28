.PHONY: test version tests build dist release
ifndef VERBOSE
.SILENT:
endif

default:
	@echo "Usage:"
	@echo "- make test         | run tests"
	@echo "- make black        | run black -l 120"
	@echo "- make release      | upload dist and push tag"

pytest:
	PYTHONPATH=. poetry run pytest --cov-report term-missing --cov=_4711 tests/

flake8:
	poetry run flake8 _4711/ tests/

version:
	poetry version `python _4711/__version__.py`

black:
	poetry run black _4711/ tests/

isort:
	poetry run isort _4711/ tests/

build:
	rm -rf dist/
	poetry build

release:
	make pytest
	make flake8
	make version
	make build
	poetry publish
	git add pyproject.toml _4711/__version__.py
	git commit -m "Bumped version" --allow-empty
	git tag -a `python _4711/__version__.py` -m `python _4711/__version__.py`
	git push
	git push --tags

test: pytest flake8
tests: test
dist: build
lint: flake8
pylint: flake8
