FROM mattwynne/changelog:latest
CMD sudo apt-get install curl
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
