#!/bin/bash

yum clean metadata > /dev/null
yum check-update 2> /dev/null > /dev/null || yum -y update --skip-broken > /dev/null
find /etc -type f -name "*.rpmnew" -exec rm -f {} \;
