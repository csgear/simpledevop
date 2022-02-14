### create 3 VMs in WLS2


- download https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-wsl.rootfs.tar.gz

#### create vms
- wsl --import Ubuntu-Master C:\WSL\UbuntuMaster focal-server-cloudimg-amd64-wsl.rootfs.tar.gz
- wsl --import Ubuntu-Frontend C:\WSL\UbuntuFront focal-server-cloudimg-amd64-wsl.rootfs.tar.gz
- wsl --import Ubuntu-Backend C:\WSL\UbuntuBack focal-server-cloudimg-amd64-wsl.rootfs.tar.gz

#### run vms
- wsl -d Ubuntu-Master
- wsl -d Ubuntu-Frontend
- wsl -d Ubuntu-Backend


### WSL connands
- wsl --list --all
- wsl -t Ubuntu