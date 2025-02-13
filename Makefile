setup:
	python3 -m venv ~/.udacity-devops

install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	#hadolint Dockerfile #uncomment to explore linting Dockerfiles
	pylint --disable=R,C,W1203 app.py

azure_webapp:
	./commands.sh

docker_build:
	./docker_commands.sh
	./upload_docker.sh

kubctl_apply:
	./kubctl_commands.sh

all: install lint test
