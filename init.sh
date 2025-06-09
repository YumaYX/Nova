#!/usr/bin/env bash

test -f /etc/redhat-release || exit 1
test $(id -u) -eq 0 || exit 2

dnf -y update
dnf -y install python3-pip git make

rm -rf /tmp/nova
git clone https://github.com/YumaYX/nova.git /tmp/nova
cd /tmp/nova && time make all
