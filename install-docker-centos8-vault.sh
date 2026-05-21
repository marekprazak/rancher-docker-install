#!/bin/sh
exec >/tmp/rancher-docker-install-wrapper.log 2>&1
set -eux

sudo rm -f /etc/yum.repos.d/*.repo

sudo tee /etc/yum.repos.d/centos-vault.repo >/dev/null <<'EOF'
[baseos]
name=CentOS-8.5.2111 BaseOS
baseurl=http://vault.centos.org/8.5.2111/BaseOS/x86_64/os/
enabled=1
gpgcheck=0

[appstream]
name=CentOS-8.5.2111 AppStream
baseurl=http://vault.centos.org/8.5.2111/AppStream/x86_64/os/
enabled=1
gpgcheck=0

[extras]
name=CentOS-8.5.2111 Extras
baseurl=http://vault.centos.org/8.5.2111/extras/x86_64/os/
enabled=1
gpgcheck=0
EOF

sudo dnf clean all
sudo dnf install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce-20.10.24 docker-ce-cli-20.10.24 containerd.io --setopt=install_weak_deps=False
sudo systemctl enable --now docker
docker --version
