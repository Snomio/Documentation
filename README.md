# Snom io documentation website

## Tools and build process

The website is built usking [mkdocs](http://www.mkdocs.org/) a static documentation website generator
Build process is done via the Makefile all the required tools to build the website (mkdocs, python etc..) are installed into a Docker container (see the docker/Dockerfile)

You can build the Docker image using the `make dbuild` command (image name is defined via the `DOCKER_IMAGE` Makefile variable).

### Build pre-processing

Some files (like some public XML examples) need to be generated at build time in order to replace some placeholders (like for example the public URL).
In order to make ti process working you have to define the replace varilabes in the Makefile, variable names must start with `TPL_` variable replacement is done via the bash script in *scripts/preprocessor.sh*.

* `make build` creates the static webiste under the `site` directory
* `make serve` creates the static webiste and start serving it using the mkdocs builting webserver
* `make gh-pages` creates the static website, commit the site into the `gh-pages` branch and push the commit to Github

## Custom template

This website is using the *mkdocs-bootstrap-snom* theme: a *mkdocs-bootstrap* modified theme.

Main changes are:

* breadcrumb bar
* possibility to hide pages from the navbar using a page name starting with **hidden**
* multilevel navbar and toc

## Github pages

Never do a commit on the gh-pages brach: your commmit will be lost after the next deploy. Use instead `make gh-pages`
