#!/bin/sh
set -eux

LOG=/tmp/rancher-docker-install-wrapper.log
exec > $LOG 2>&1

cat >/etc/yum.repos.d/CentOS-Linux-BaseOS.repo <<'EOF'
[baseos]
name=CentOS Linux 8.5.2111 - BaseOS
baseurl=http://vault.centos.org/8.5.2111/BaseOS/x86_64/os/
enabled=1
gpgcheck=0
EOF

cat >/etc/yum.repos.d/CentOS-Linux-AppStream.repo <<'EOF'
[appstream]
name=CentOS Linux 8.5.2111 - AppStream
baseurl=http://vault.centos.org/8.5.2111/AppStream/x86_64/os/
enabled=1
gpgcheck=0
EOF

cat >/etc/yum.repos.d/CentOS-Linux-Extras.repo <<'EOF'
[extras]
name=CentOS Linux 8.5.2111 - Extras
baseurl=http://vault.centos.org/8.5.2111/extras/x86_64/os/
enabled=1
gpgcheck=0
EOF

dnf clean all
dnf makecache -y

curl -fsSL https://releases.rancher.com/install-docker/20.10.sh | sh
