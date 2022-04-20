#!/bin/bash

# DigitalOcean first-boot journal gets corrupted, create a new one
systemctl restart systemd-journald.service

# install Caddy
curl \
  --show-error \
  --silent \
  --remote-header-name \
  --remote-name \
  "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Faksdb%2Fcaddy-cgi%2Fv2&idempotency=45911821411451"
cp caddy_linux_amd64_custom /usr/bin/caddy
chmod 755 /usr/bin/caddy
rm --force caddy_linux_amd64_custom

# install BlueSky Server
curl \
  --show-error \
  --silent \
  --remote-header-name \
  --remote-name \
  "https://github.com/smaddock/bluesky-server/releases/download/v3.0.0a/bluesky-server-v3.0.0a-linux-all.tar.gz"
apt install ./bluesky-server_3.0.0_1_all.deb
rm --force bluesky-server_3.0.0_1_all.deb

# start the web server
systemctl enable --now caddy
