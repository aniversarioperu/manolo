.PHONY: clean-pyc clean-build docs

help:
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "lint - check style with flake8"
	@echo "test - run tests quickly with the default Python"
	@echo "testall - run tests on every Python version with tox"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "docs - generate Sphinx HTML documentation, including API docs"
	@echo "release - package and upload a release"
	@echo "sdist - package"
	@echo "migrations - apply Django model migrations"
	@echo "serve - serve Django project for local development"
	@echo "serve-production - serve Django project for production database postgreSQL"

clean: clean-build clean-pyc

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

lint:
	flake8 django-manolo tests

test:
	rm -rf htmlcov
	python manage.py makemigrations --settings=manolo.settings.testing
	python manage.py migrate --settings=manolo.settings.testing
	coverage run --source manolo manage.py test -v 2 api visitors cazador --settings=manolo.settings.testing

test-all:
	tox

coverage: test
	coverage report -m
	coverage html

coverage-gitlab:
	coverage run --source="manolo" manage.py test -v 2 --noinput --testrunner="xmlrunner.extra.djangotestrunner.XMLTestRunner" api.tests visitors.tests cazador.tests --settings=manolo.settings.testing
	coverage report --skip-covered

docs:
	rm -f docs/django-manolo.rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ manolo
	$(MAKE) -C docs clean
	$(MAKE) -C docs html

release: clean
	python setup.py sdist upload
	python setup.py bdist_wheel upload

sdist: clean
	python setup.py sdist
	ls -l dist


# import database from django-manolo

migrations:
	python manage.py makemigrations --settings=manolo.settings.local
	python manage.py migrate --settings=manolo.settings.local

migrations-production:
	python manage.py makemigrations --settings=manolo.settings.production
	python manage.py migrate --settings=manolo.settings.production

serve:
	python manage.py runserver --settings=manolo.settings.local

serve-production:
	python manage.py rebuild_index --settings=manolo.settings.production
	python manage.py runserver --settings=manolo.settings.production
