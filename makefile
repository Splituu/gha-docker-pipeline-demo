IMAGE_NAME="gha-docker-pipeline-demo"
REGISTRY=ghcr.io/splituu/gha-docker-pipeline-demo
VERSION=$(shell cat version.txt | tr -d '[:space:]')
GIT_SHA=$(shell git rev-parse --short HEAD)

build:
	docker build -t "$(IMAGE_NAME):$(GIT_SHA)" -t "$(IMAGE_NAME):$(VERSION)" .

test: 
	build
	mkdir -p junit
	docker run --rm \
		-v $(PWD)/junit:/app/junit \
		$(IMAGE_NAME):$(GIT_SHA) \
		pytest --junitxml=junit/report.xml

push:
	docker tag $(IMAGE_NAME):$(GIT_SHA) $(REGISTRY):$(GIT_SHA)
	docker tag $(IMAGE_NAME):$(VERSION) $(REGISTRY):$(VERSION)
	docker push $(REGISTRY):$(GIT_SHA)
	docker push $(REGISTRY):$(VERSION)

release: build push