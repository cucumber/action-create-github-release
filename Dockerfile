FROM mattwynne/changelog:latest AS build

FROM alpine:latest
RUN apk add --no-cache curl jq  git openssh
COPY --from=build /usr/local/bin/changelog /usr/local/bin/changelog
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
