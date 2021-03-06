FROM ubuntu:20.04

RUN apt-get update && apt-get install -yq sudo curl

# Turn on passwordless sudo for ubuntu
RUN echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN useradd -m -s /usr/bin/bash ubuntu

USER ubuntu

WORKDIR /home/ubuntu/workspace/dotfiles/
