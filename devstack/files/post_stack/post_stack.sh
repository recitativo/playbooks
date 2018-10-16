#!/bin/bash

# reset zun.conf and restart zun
sudo cp -f ~stack/post_stack/zun.conf /etc/zun/zun.conf
sudo systemctl restart devstack@zun-api.service
sudo systemctl restart devstack@zun-compute.service
sudo systemctl restart devstack@zun-wsproxy.service

# reset docker.service and restart docker
sudo cp -f ~stack/post_stack/docker.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl restart docker

# switch local_settings.py and restart horizon
cp -f ~stack/post_stack/local_settings.py /opt/stack/horizon/openstack_dashboard/local/
sudo systemctl restart apache2
