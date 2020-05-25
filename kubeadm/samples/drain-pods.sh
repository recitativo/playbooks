#!/bin/bash

# drain pods from nodes to prevent rescheduling pods
kubectl drain --ignore-daemonsets master01
kubectl drain --ignore-daemonsets master02
kubectl drain --ignore-daemonsets master03
kubectl drain --ignore-daemonsets worker01
kubectl drain --ignore-daemonsets worker02
kubectl drain --ignore-daemonsets worker03
