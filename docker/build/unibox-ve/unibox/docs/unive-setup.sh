#! /bin/bash

### set up unibox-ve on eyekraft cassa computer

useradd -m -p unI2O3 -s /bin/bash uni
usermod -a -G sudo uni
usermod -a -G dialout uni

apt install -y python3-virtualenv

scp -r eye@172.17.0.33:/home/eye/unibox-ve/storage /home/uni/
scp -r eye@172.17.0.33:/home/eye/unibox-ve/unibox /home/uni/

cd /home/uni&&mkdir ve&&cd ve
virtualenv --python=$(which python2) unibox
wait
source /home/uni/ve/unibox/bin/activate
wait
pip install --upgrade pip
pip install -r /home/uni/unibox/requirements.txt

chown -R uni /home/uni
scp eye@172.17.0.33:/home/eye/unibox-ve/etc-systemd-system/unibox.service /etc/systemd/system
systemctl enable unibox
systemctl start unibox
systemctl status unibox
