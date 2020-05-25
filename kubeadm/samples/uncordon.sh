#!/bin/bash

# uncordon nodes for pods
kubectl uncordon master01
kubectl uncordon master02
kubectl uncordon master03
kubectl uncordon worker01
kubectl uncordon worker02
kubectl uncordon worker03
