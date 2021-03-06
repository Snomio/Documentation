# Snom io documentation website

## Tools and build process

The website is built usking [mkdocs](http://www.mkdocs.org/) a static documentation website generator
Build process is done via the Makefile all the required tools to build the website (mkdocs, python etc..) are installed into a Docker container (see the docker/Dockerfile)

You can build the Docker image using the `make dbuild` command (image name is defined via the `DOCKER_IMAGE` Makefile variable).

### Build pre-processing

Some files (like some public XML examples) need to be generated at build time in order to replace some placeholders (like for example the public URL).
In order to make ti process working you have to define the replace varilabes in the Makefile, variable names must start with `TPL_` variable replacement is done via the bash script in *scripts/preprocessor.sh*.

* `make prebuild` pre-process the template files and generate the files
* `make build` creates the static webiste under the `site` directory
* `make serve` creates the static webiste and start serving it using the mkdocs builting webserver
* `make gh-pages` creates the static website, commit the site into the `gh-pages` branch and push the commit to Github. **NOTE:** Never do a commit on the gh-pages brach: your commmit will be lost after the next deploy. Use instead `make gh-pages`

## Custom template

This website is using the *mkdocs-bootstrap-snom* theme: a *mkdocs-bootstrap* modified theme.

Main changes are:

* breadcrumb bar
* possibility to hide pages from the navbar using a page name starting with **hidden**
* multilevel navbar and toc

## Deploying the website locally

Thanks to the pre-processing mechanism all the provided examples are woring directly from the published pages.
If for some reasons you want to re-deploy the whole site and examples in a your server you have to:

1. Clone this repository
1. Change the `TPL_ROOT_URL` according with your webserver IP / name and root path
1. Build the website using `make build` if you want to serve the `site` directory using your own web server. If you want to serve the pages using the Mkdocs builtin webserver you have to run `make serve`

**NOTE:** In order to deploy the site you need Docker installed, otherwise you have do slightly modify the Makefile in order to use Mkdocs directly (all the requiremnts are listed in Docker/requirements.txt)
