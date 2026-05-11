#!/bin/env bash
# Scirpt to setup pacman mirrors before any update

cat <<'EOF' >/etc/pacman.conf
[options]
HoldPkg     = pacman glibc
Architecture = auto
#IgnorePkg   = poppler
#IgnoreGroup =
#UseSyslog
Color
#NoProgressBar
CheckSpace
VerbosePkgLists
ParallelDownloads = 10
DownloadUser = alpm
#DisableSandbox
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required
# NOTE: You must run 'pacman-key --init' before first using pacman; the local
# keyring can then be populated with the keys of all official Arch Linux
# packagers with 'pacman-key --populate archlinux'

[core]
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch
#Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.hit.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.hust.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.jlu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.jxust.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.nju.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirror.nyist.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.wsyu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.xjtu.edu.cn/archlinux/$repo/os/$arch

[extra]
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch
#Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.hit.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.hust.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.jlu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.jxust.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.nju.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirror.nyist.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.wsyu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.xjtu.edu.cn/archlinux/$repo/os/$arch

#[multilib]
#Include = /etc/pacman.d/mirrorlist

[archlinuxcn]
# Server = https://repo.archlinuxcn.org/$arch
Server = https://mirrors.cernet.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.bfsu.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.pku.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.cloud.tencent.com/archlinuxcn/$arch
Server = https://mirrors.163.com/archlinux-cn/$arch
# Server = https://mirrors.aliyun.com/archlinuxcn/$arch
# Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.hit.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.jlu.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.zju.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.cqu.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.cqupt.edu.cn/archlinuxcn/$arch
# Server = https://mirror.sjtu.edu.cn/archlinux-cn/$arch
# Server = https://mirrors.nju.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.sustech.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.hust.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.wsyu.edu.cn/archlinuxcn/$arch
# Server = https://mirror.bjtu.edu.cn/archlinuxcn/$arch
# Server = https://mirror.lzu.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.xjtu.edu.cn/archlinuxcn/$arch
# Server = https://mirror.nyist.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.shanghaitech.edu.cn/archlinuxcn/$arch
# Server = https://mirror.iscas.ac.cn/archlinuxcn/$arch
# Server = https://mirrors.cicku.me/archlinuxcn/$arch
# Server = https://archlinux.ccns.ncku.edu.tw/archlinuxcn/$arch
# Server = https://mirror.twds.com.tw/archlinuxcn/$arch
# Server = https://mirrors.ocf.berkeley.edu/archlinuxcn/$arch

EOF
