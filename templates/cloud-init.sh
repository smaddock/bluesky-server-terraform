#!/bin/bash
set -exuo pipefail

# Debian 11 (Bullseye) builds have a typo in the APT source list
sed \
    --expression="s|http://security.debian.org bullseye/updates|http://security.debian.org bullseye-security|g" \
    --in-place \
    /etc/apt/sources.list

# DigitalOcean first-boot journal gets corrupted, create a new one
systemctl restart systemd-journald.service

# Upgrade and install packages
apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get upgrade --assume-yes --with-new-pkgs > /dev/null
DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes caddy jq sqlite3 > /dev/null

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

# swap packaged Caddy binary with one bundled with CGI module
curl \
  --show-error \
  --silent \
  --remote-header-name \
  --remote-name \
  "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Faksdb%2Fcaddy-cgi%2Fv2&idempotency=45911821411451"
dpkg-divert --divert /usr/bin/caddy.default --rename /usr/bin/caddy
cp ./caddy_linux_amd64_custom /usr/bin/caddy.custom
chmod 755 /usr/bin/caddy.custom
update-alternatives --install /usr/bin/caddy caddy /usr/bin/caddy.default 10
update-alternatives --install /usr/bin/caddy caddy /usr/bin/caddy.custom 50
rm --force caddy_linux_amd64_custom
rm --force /etc/caddy/Caddyfile
mv /etc/caddy/Caddyfile.bluesky /etc/caddy/Caddyfile
chown caddy:caddy /etc/caddy/Caddyfile
systemctl restart caddy

# update the SSH server
rm --force /etc/ssh/sshd_config
mv /etc/ssh/sshd_config.bluesky /etc/ssh/sshd_config
systemctl reload sshd
