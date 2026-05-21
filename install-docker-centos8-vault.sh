#!/bin/sh
set -eux

rm -f /etc/yum.repos.d/*openlogic*

cat >/etc/yum.repos.d/centos-vault.repo <<'EOF'
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

dnf clean all
dnf makecache

dnf install -y \
  yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y \
  docker-ce-20.10.* \
  docker-ce-cli-20.10.* \
  containerd.io

systemctl enable docker
systemctl start docker

docker --version
