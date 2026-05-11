#!/bin/env bash
# setup the system

# timezone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# time adjust
hwclock --systohc

# fstab
genfstab -U / >/etc/fstab

# locales
cat <<'EOF' >/etc/locale.gen
en_GB.UTF-8 UTF-8  
en_US.UTF-8 UTF-8  
zh_CN.GB18030 GB18030  
zh_CN.GBK GBK  
zh_CN.UTF-8 UTF-8  
zh_CN GB2312  
EOF
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf

# hostname
echo "default" >/etc/hostname

# add user 'peng'
peng_initial_passwd='$y$j9T$UQCNR6geVDFCK6KUsTzN51$JAZSQIeHhqY5l4lVt02.KJ53U0/a2DA4/0Dqj4PTtU/'
peng_comment="Peng Lei (The Best!)"
peng_shell="/usr/bin/fish"
peng_extragroups="wheel "

root_comment=""
root_shell="/usr/bin/fish"

if getent passwd "peng" >/dev/null; then
  usermod -aG "$peng_extragroups" -c "$peng_comment" -s $peng_shell peng
else
  useradd -G "$peng_extragroups" -g users -c "$peng_comment" -s $peng_shell -p "$peng_initial_passwd" peng
fi

usermod -c "$root_comment" -s "$root_shell" root
