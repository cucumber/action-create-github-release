FROM cucumber/changelog:0.10.0 AS build

FROM alpine:latest
RUN apk add --no-cache curl jq
COPY --from=build /changelog /changelog
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
