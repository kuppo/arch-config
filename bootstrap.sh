#!/bin/env bash

# The script assume the root partition mounted on /mnt

# change host (boot installation media) pacman settings.
cat <<'EOF' >/etc/pacman.conf
[options]
HoldPkg     = pacman glibc
Architecture = auto
CheckSpace
VerbosePkgLists
ParallelDownloads = 10
DownloadUser = alpm
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

[extra]
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

[archlinuxcn]
Server = https://mirrors.cernet.edu.cn/archlinuxcn/$arch
Server = https://mirrors.163.com/archlinux-cn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch

EOF

# install keyring
pacman -Sy archlinux-keyring archlinuxcn-keyring --noconfirm

# set up hostname
read -p "Enter your hostname: " your_hostname
echo "$your_hostname" >/mnt/etc/hostname

# install the base system
pacstrap -K /mnt base git
