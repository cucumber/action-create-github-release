FROM mattwynne/changelog:latest
RUN apk add curl
RUN apk add jq
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
