FROM mattwynne/changelog:latest
RUN apk add curl
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
