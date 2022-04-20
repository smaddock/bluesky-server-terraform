#!/bin/bash

# DigitalOcean first-boot journal gets corrupted, create a new one
systemctl restart systemd-journald.service

# install Caddy with CGI module
curl \
  --show-error \
  --silent \
  --remote-header-name \
  --remote-name \
  "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Faksdb%2Fcaddy-cgi%2Fv2&idempotency=45911821411451"
cp caddy_linux_amd64_custom /usr/bin/caddy
chmod 755 /usr/bin/caddy
rm --force caddy_linux_amd64_custom

# install latest BlueSky Server release
DL_URL=$(curl --silent "https://api.github.com/repos/smaddock/bluesky-server/releases/latest" |
    jq --raw-output ".assets[0].browser_download_url")
curl \
  --location \
  --output bluesky-server.deb \
  --show-error \
  --silent \
  "$DL_URL"
apt install ./bluesky-server.deb
rm --force bluesky-server.deb

# start the web server
systemctl enable --now caddy
