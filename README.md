<div style="text-align:center"><img src ="/static/dotfiles.png" /></div>

A collection of my config files. Tested (to various degrees) on OS X, Debian,
Raspbian, and Ubuntu.

## Installation

The installation [init.sh](./init.sh) script can be piped directly to bash, but
you should probably inspect it before running random bash scripts from the
internet:

```bash
# Make sure you pass this as the first argument, otherwise you'll be adding
# _my_ public keys to your machine!
$YOUR_GITHUB_USERNAME=philipforget

# To use the main branch
curl -fL init.chevalierforget.com | bash -s -- $YOUR_GITHUB_USERNAME

# Or to use a specific branch, eg `some-feature`
curl -fL init.chevalierforget.com/some-feature | bash -s -- $YOUR_GITHUB_USERNAME
```


## Try it out in a Docker container

Give this repo a try in a docker container using the Dockerfile:

```bash
# If you've already got the repo checked out, from the repo root:
docker build . -t dotfiles
docker run --rm -it -v ${PWD}:/home/ubuntu/workspace/dotfiles/:ro bash -c './init.sh; bash'
```

```bash
# Or to build the Docker image and run the init script from github directly:
curl -fL https://raw.githubusercontent.com/philipforget/dotfiles/main/Dockerfile | \
  docker build -t dotfiles-test - && \
  docker run --rm -it -h dotfiles-test dotfiles-test  \
    bash -c 'curl -fL init.chevalierforget.com | bash; /bin/bash'
```

You'll be dropped into a container after it finishes running `init.sh` for the
`ubuntu` user.

Keep in mind that I only manage this script for myself right now, and so it
will populate my own ssh public keys when run.
