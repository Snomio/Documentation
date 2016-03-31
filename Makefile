.PHONY: build serve dbuild gh-pages

DOCKER_IMAGE=mkdocs
TPL_ROOT_URL=http://172.16.18.15:8001
LISTEN_ADDR=0.0.0.0

export TPL_ROOT_URL

dcleanup:
	-docker kill mkdocs_io
	-docker rm mkdocs_io

dbuild:
	cd docker; docker build -t $(DOCKER_IMAGE) .

build: dcleanup
	for file in $(shell find docs -name "*.tpl"); do \
		./scripts/preprocessor.sh $$file; \
	done
	docker run -it -v $(PWD):/opt/data --name mkdocs_io --rm -p 8001:8001 --net=host $(DOCKER_IMAGE) build --clean

serve: dcleanup build
	docker run -d -v $(PWD):/opt/data --name mkdocs_io -p 8001:8001 --net=host $(DOCKER_IMAGE) serve -a $(LISTEN_ADDR):8001

gh-pages: dcleanup
	docker run --rm -it -v $(PWD):/opt/data -v $(HOME)/.gitconfig:/root/.gitconfig -v $(HOME)/.ssh:/root/.ssh --name mkdocs_io -p 8001:8001 --net=host $(DOCKER_IMAGE) gh-deploy --clean
