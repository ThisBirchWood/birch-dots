#!/usr/bin/env bash

## SDDM Confs
sudo mkdir -p /etc/sddm.conf.d
sudo cp -a system/sddm.conf.d /etc/
sudo cp -a system/sddm /etc/
sudo chown -R root:root /etc/sddm.conf.d /etc/sddm
sudo chmod -R 644 /etc/sddm.conf.d /etc/sddm
