Create VMs for libvirt
======================

This scripts create Ubutu VMs from cloud image using libvirt.

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
cloud init does not create swap as default.
create cloud init CD image using `cloud-localds`

# VMs
To manage libvirt VMs, the role uses `virt` module.
To connect libvirt, the `libvirt_uri` variable should be set.
If VM is existing by name, role will not re-create the VM.
To define VM, use `define` command on `virt` module.
To start VM, use `start` command on `virt` module.

# TODOs
use `tags` for task to re-create VMs.
