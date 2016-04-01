.PHONY: prebuild build serve dbuild gh-pages

DOCKER_IMAGE=mkdocs
MKDOCS_PORT=8001
# Local root URL
#TPL_ROOT_URL=http://172.16.18.15:$(8001)
# Production Root URL
TPL_ROOT_URL=http://snomio.github.io/Documentation
LISTEN_ADDR=0.0.0.0
SSH_KEY=.ssh/id_dsa

export TPL_ROOT_URL

dcleanup:
	-docker kill mkdocs_io
	-docker rm mkdocs_io

dbuild:
	cd docker; docker build -t $(DOCKER_IMAGE) .

prebuild:
	for file in $(shell find docs -name "*.tpl"); do \
		./scripts/preprocessor.sh $$file; \
	done

build: dcleanup prebuild
	docker run -it -v $(PWD):/opt/data --name mkdocs_io --rm -p $(MKDOCS_PORT):$(MKDOCS_PORT) --net=host $(DOCKER_IMAGE) build --clean

serve: dcleanup build
	docker run -d -v $(PWD):/opt/data --name mkdocs_io -p $(MKDOCS_PORT):$(MKDOCS_PORT) --net=host $(DOCKER_IMAGE) serve -a $(LISTEN_ADDR):$(MKDOCS_PORT)

gh-pages: prebuild dcleanup
	docker run --rm -it -v $(PWD):/opt/data -v $(HOME)/.gitconfig:/root/.gitconfig -v $(HOME)/$(SSH_KEY):/root/$(SSH_KEY) --name mkdocs_io --net=host $(DOCKER_IMAGE) gh-deploy --clean
	git checkout master
