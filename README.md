<div style="text-align:center"><img src ="/static/dotfiles.png" /></div>

A collection of my config files. Tested (to various degrees) on OS X, Debian,
Raspbian, and Ubuntu.

## Installation

The installation [init.sh](./init.sh) script can be piped directly to bash, but
you should probably inspect it before running random bash scripts from the
internet:

```bash
# If you want your github public keys to be added, specify your username as the
# first argument
$YOUR_GITHUB_USERNAME=philipforget

# To use the main branch
curl -sfL init.chevalierforget.com | bash -s -- $YOUR_GITHUB_USERNAME

# Or to use a specific branch, eg `some-feature`
curl -sfL init.chevalierforget.com/some-feature | bash -s -- $YOUR_GITHUB_USERNAME
```


## Try it out in a Docker container

Give this repo a try in a docker container using the Dockerfile:

```bash
# If you've already got the repo checked out, from the repo root:
docker build . -t dotfiles
docker run --rm -it -v "${PWD}:/home/dotfiles/workspace/dotfiles/:ro" dotfiles bash -c './init.sh; bash'
```

```bash
# Or to build the Docker image and run the init script from github directly:
curl -sfL https://raw.githubusercontent.com/philipforget/dotfiles/main/Dockerfile | \
  docker build -t dotfiles - && \
  docker run --rm -it -h dotfiles dotfiles  \
    bash -c 'curl -sfL init.chevalierforget.com | bash; bash'
```

You'll be dropped into a container after it finishes running `init.sh` for the
`dotfiles` user.
