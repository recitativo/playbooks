#!/bin/bash

export KUBECONFIG=/etc/kubernetes/admin.conf

kubeadm alpha phase certs all --config /root/kubeadm-config.yaml
kubeadm alpha phase kubelet config write-to-disk --config /root/kubeadm-config.yaml
kubeadm alpha phase kubelet write-env-file --config /root/kubeadm-config.yaml
kubeadm alpha phase kubeconfig kubelet --config /root/kubeadm-config.yaml
service kubelet restart

# Choose for master02 or master03
#kubectl exec -n kube-system etcd-${CP0_HOSTNAME}        -- etcdctl --ca-file /etc/kubernetes/pki/etcd/ca.crt --cert-file /etc/kubernetes/pki/etcd/peer.crt --key-file /etc/kubernetes/pki/etcd/peer.key --endpoints=https://${CP0_IP}     :2379 member add ${CP1_HOSTNAME}        https://${CP1_IP}     :2380
kubectl exec -n kube-system etcd-multi-master01.example -- etcdctl --ca-file /etc/kubernetes/pki/etcd/ca.crt --cert-file /etc/kubernetes/pki/etcd/peer.crt --key-file /etc/kubernetes/pki/etcd/peer.key --endpoints=https://192.168.100.41:2379 member add multi-master02.example https://192.168.100.42:2380
kubectl exec -n kube-system etcd-multi-master01.example -- etcdctl --ca-file /etc/kubernetes/pki/etcd/ca.crt --cert-file /etc/kubernetes/pki/etcd/peer.crt --key-file /etc/kubernetes/pki/etcd/peer.key --endpoints=https://192.168.100.41:2379 member add multi-master03.example https://192.168.100.42:2380

kubeadm alpha phase etcd local --config kubeadm-config.yaml


kubeadm alpha phase kubeconfig all --config kubeadm-config.yaml
kubeadm alpha phase controlplane all --config kubeadm-config.yaml
kubeadm alpha phase mark-master --config kubeadm-config.yaml

