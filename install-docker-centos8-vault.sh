#!/bin/bash
set -e

echo "[INFO] Fixing CentOS 8 repositories to vault.centos.org"

sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=https://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

dnf clean all
dnf makecache -y

echo "[INFO] Running Rancher Docker installer"

curl -fsSL https://releases.rancher.com/install-docker/20.10.sh | sh
