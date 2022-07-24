FROM alpine:latest

# TARGETARCH will be amd64 or arm64
ARG TARGETARCH

RUN \
  # install packages
  apk --no-cache add tinyproxy && \
  # allow access to the http proxy from anywhere by commenting out all allow statements
  sed -i 's/^Allow .*/#&/g' /etc/tinyproxy/tinyproxy.conf && \
  # reduce log verbosity
  sed -i 's/^LogLevel .*/LogLevel Connect/' /etc/tinyproxy/tinyproxy.conf

# start tinyproxy in the foreground
ENTRYPOINT [ "tinyproxy", "-d" ]

# expose tinyproxy port
EXPOSE 8888
