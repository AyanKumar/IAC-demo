#!/bin/bash
$1

sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version
sudo curl -s https://api.github.com/repos/goharbor/harbor/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep '\.tgz$' | wget -qi -
sudo tar xvzf harbor-offline-installer-v2.2.0.tgz
sudo mv harbor.yml harbor/harbor.yml
sudo sed -i "s/^hostname:.*/hostname: $1/" harbor/harbor.yml
whereis docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo chmod +x ./harbor/install.sh
sudo ./harbor/install.sh --with-chartmuseum