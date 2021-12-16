FROM debian:stretch-slim

ARG user=dotfiles
ARG id=86758

RUN apt-get update && apt-get install -yq \
    curl \
    locales-all \
    procps \
    sudo

# Turn on passwordless sudo for ubuntu
RUN echo "${user} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN groupadd --gid ${id} ${user} && \
    useradd \
      --create-home \
      --shell /bin/bash \
      --gid ${id} \
      --uid ${id} \
      ${user}

USER ${user}

WORKDIR /home/${user}
