FROM mattwynne/changelog:latest
CMD apt install curl
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
