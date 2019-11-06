FROM debian:stable
MAINTAINER Akito <akito.kitsune@protonmail.com>
RUN                                                                       \
  /bin/sh -c "ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime" && \
  apt-get -y update                                                    && \
  echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/mirror-retry      && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install                    && \
    --no-install-recommends                                               \
    pkg-config                                                            \
    build-essential                                                       \
    m4                                                                    \
    software-properties-common                                            \
    dialog                                                                \
    libx11-dev                                                            \
    libcap-dev                                                            \
    ocaml                                                                 \
    ocaml-native-compilers                                                \
    camlp4-extra                                                          \
    opam                                                               && \
  apt-get clean && rm -rf /var/lib/apt/lists/*                         && \
  echo 'opam ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/opam         && \
  chmod 440 /etc/sudoers.d/opam                                        && \
  chown root:root /etc/sudoers.d/opam                                  && \
  adduser --uid 1000 --disabled-password --gecos '' opam               && \
  passwd -l opam                                                       && \
  chown -R opam:opam /home/opam
COPY docker/opam2 /usr/local/bin/opam
USER opam
ENV HOME=/home/opam
WORKDIR /home/opam
RUN                                                                       \
  opam init --bare -a --disable-sandboxing                             && \
  eval $(opam env)                                                     && \
  opam switch create 4.02.2 ocaml-base-compiler.4.02.2                 && \
  eval $(opam env)                                                     && \
  opam switch 4.02.2                                                   && \
  eval $(opam env)                                                     && \
  /bin/sh -c "opam install -y depext"                                  && \
  eval $(opam env)                                                     && \
  /bin/sh -c "opam install -y batsh.0.0.6"                             && \
  eval $(opam env)                                                     && \
  rm /home/opam/.bash_profile /home/opam/.bash_login                   && \
  echo "eval $(opam env)" >> /home/opam/.bashrc
ENV OPAMYES=1
CMD ["/bin/sh" "-c" "bash"]