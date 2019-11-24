FROM alpine:latest
LABEL maintainer="Akito <akito.kitsune@protonmail.com>"         \
      batsh.version="0.0.7"                                     \
      batsh.source="https://github.com/darrenldl/Batsh"         \
      batsh.source.deprecated="https://github.com/BYVoid/Batsh"
RUN                                                             \
  adduser --uid 1000 --disabled-password --gecos '' batsh    && \
  chown -R batsh:batsh /home/batsh
COPY docker/batsh /usr/bin
USER batsh
ENV HOME=/home/batsh
WORKDIR /home/batsh
ENV TERM xterm
ENTRYPOINT ["sh"]
