Setup kubernetes cluster
========================

This scripts setup kubernetes cluster Ubuntu VMs from cloud image using libvirt.

# How to use

Before run playbook, run `ssh-agent bash` and `ssh-add <ssh key file>` to access `libvirt_host` via ssh.

## Install dependencies

Run playbook with `-k` option for input ssh passphrase and `-K` option for `sudo`.
```
ansible-playbook -i ../libvirt/dist/<allinone|single|multi> site.yaml -k -K
```

## Bootstrap cluster

Run playbook with `-k` option for input ssh passphrase and `-K` option for `sudo`.
```
ansible-playbook -i <single> single.yaml -k -K
```
or
```
ansible-playbook -i <multi> bootstrap.yaml -k -K
```

## Use DNS server on `frontend` instance to access inside cluster, e.g. your services.

Add record into `/etc/hosts` and reboot your machine.

```
# k8s HA cluster frontend with haproxy
#192.168.100.40  multi-master.example

# k8s HA cluster frontend with DNS roundrobbin
192.168.100.41  multi-master.example
192.168.100.42  multi-master.example
192.168.100.43  multi-master.example

```

## Check cluster with adding nginx service

Login to any node with SSH.
```
sudo -i
export KUBECONFIG=/etc/kubernetes/admin.conf
# Copy `nginx_test_deploy.yaml` and `nginx_test_service.yaml` from `playbooks/kubeadm/files/` to any node.
kubectl apply -f nginx_test_deploy.yaml
kubectl apply -f nginx_test_service.yaml
kubectl get svc/nginx
```

Then, access the nginx service from web client with high-port number.
e.g. http://multi-master.example:30080
