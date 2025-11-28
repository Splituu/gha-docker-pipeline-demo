IMAGE_NAME="gha-docker-pipeline-demo"
REGISTRY=ghcr.io/splituu/gha-docker-pipeline-demo
VERSION=$(shell cat version.txt | tr -d '[:space:]')
GIT_SHA=$(shell git rev-parse --short HEAD)

build:
	docker build -t "$(IMAGE_NAME):$(GIT_SHA)" -t "$(IMAGE_NAME):$(VERSION)" .

push:
	docker tag $(IMAGE_NAME):$(GIT_SHA) $(REGISTRY):$(GIT_SHA)
	docker tag $(IMAGE_NAME):$(VERSION) $(REGISTRY):$(VERSION)
	docker push $(REGISTRY):$(GIT_SHA)
	docker push $(REGISTRY):$(VERSION)

run-local:
	mkdir -p junit
	docker run --rm -p 8000:8000 \
		-v $(pwd)/junit:/app/junit \
		$(IMAGE_NAME):$(VERSION)

run-remote:
	mkdir -p junit
	docker run --rm \
		-v $(pwd)/junit:/junit \
		$(REGISTRY):$(VERSION) \
		pytest tests/ -vv --junitxml=/junit/report.xml

release: build push

clean:
	docker system prune -f