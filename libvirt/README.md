Create VMs for libvirt
======================

This scripts create Ubuntu VMs from cloud image using libvirt.

# Reference
https://youth2009.org/post/kvm-with-ubuntu-cloud-image/
https://help.ubuntu.com/community/CloudInit
https://cloudinit.readthedocs.io/en/latest/topics/examples.html#yaml-examples
https://cloudinit.readthedocs.io/en/latest/topics/network-config-format-v2.html#examples

# Pre-requicites

## On libvirt host

```
sudo apt install qemu-kvm libvirt-bin virtinst bridge-utils cloud-image-utils whois
```

# Cloud Init
Cloud init does not create swap as default.
Create cloud init CD image using `cloud-localds`

# VMs
To manage libvirt VMs, the role uses `virt` module.
To connect libvirt, the `libvirt_uri` variable should be set.
If VM is existing by name, role will not re-create the VM.
To define VM, use `define` command on `virt` module.
To start VM, use `start` command on `virt` module.

# TODOs
use `tags` for task to re-create VMs.

# How to use

Before run playbook, run `ssh-agent bash` and `ssh-add <ssh key file>` to access `libvirt_host` via ssh.
Run playbook with `-k` option for input ssh passphrase and `-K` option for `sudo`.
```
ansible-playbook -v -i <stage> sites.yaml -k -K
```

* `sites.yaml`: `libvirt-hosts`
  + `stage`: Environments to be managed
    - `desktop`: For desktop machine
    - `laptop`: For laptop machine
  + `cluster_type`: Kubernetes cluster type
    - `single`: For single master and workers
    - `minimum`: For multi tainted masters
    - `medium`: For multi masters and workers
    - `allinone`: All-in-one single node incldes development environment

_Note that `cluster_type`: `allinone` is for playbook `devkube`, and others are for playbook `kubeadm`._

Inventory file for bootstrapping k8s cluster with created VMs will be generated into this directory as `./dist/{{stage}}-{{cluster_type}}`.

# Start/Stop/Restart VMs

When you stop k8s cluster nodes, you need to run followings for tainted masters and workers to prevent rescheduling pods.

Befor stop:
```
kubectl drain --ignore-daemonsets <node>
```

Then run stop:
```
ansible-playbook -i <stage> <stop.yaml|restart.yaml>
```

After start k8s cluster nodes, you need to `uncordon` for tainted masters and workers.

To start:
```
ansible-playbook -i <stage> start.yaml
```

After start:
```
kubectl uncordon <node>
```
