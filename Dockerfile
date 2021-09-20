FROM mattwynne/changelog:latest
CMD apk add curl
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
