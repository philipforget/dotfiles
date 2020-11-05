<div style="text-align:center"><img src ="/static/dotfiles.png" /></div>

A collection of my config files. Tested (to various degrees) on OS X, Debian,
Raspbian, and Ubuntu.

## Installation

The installation [init.sh](./init.sh) script can be piped directly to bash, but
you should probably inspect it before running random bash scripts from the
internet:

```bash
curl -fL init.chevalierforget.com | bash
```


## Try it out in a Docker container

Give this repo a try in a docker container using the Dockerfile:

```bash
curl -fL https://raw.githubusercontent.com/philipforget/dotfiles/master/Dockerfile | \
  docker build -t dotfiles-test - && \
  docker run --rm -it dotfiles-test  \
    bash -c 'curl -fL init.chevalierforget.com | bash; /bin/bash'
```

You'll be dropped into a container after it finishes running `init.sh` for the `ubuntu` user.
