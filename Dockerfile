FROM mattwynne/changelog:latest
RUN apk add --no-cache wget
RUN wget https://github.com/cli/cli/releases/download/v1.14.0/gh_1.14.0_linux_386.tar.gz -O ghcli.tar.gz
RUN tar --strip-components=1 -xf ghcli.tar.gz
ENV PATH="${PATH}:bin/"
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
