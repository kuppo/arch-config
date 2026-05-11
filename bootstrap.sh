#!/bin/env bash

# The script assume the root partition mounted on /mnt

# packages need to be in place
packages="sudo archlinuxcn-keyring archlinux-keyring yay base"

shell=""

# verify if the /mnt is mounted
function mounted() {
  if ! mountpoint -q "/mnt"; then
    echo "/mnt is not mounted. Exit!"
    exit 1
  fi
}

# change installation media pacman settings.
function pacman_config() {
  cat <<'EOF' >/etc/pacman.conf
[options]
HoldPkg     = pacman glibc
Architecture = auto
CheckSpace
Color
VerbosePkgLists
ParallelDownloads = 10
DownloadUser = alpm
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Server = https://mirrors.cernet.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch

[extra]
Server = https://mirrors.cernet.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch

[archlinuxcn]
Server = https://mirrors.cernet.edu.cn/archlinuxcn/$arch
Server = https://mirrors.163.com/archlinux-cn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
EOF
}

# install packages
function install_pkgs() {
  # install for the local
  echo "Update the installation media keyring..."
  pacman -Sy archlinux-keyring archlinuxcn-keyring --noconfirm #>/dev/null 2>&1
  echo
}

# set up hostname
function setup_hostname() {
  read -p "Enter your hostname: " your_hostname
  echo "Your hostname will be set to $your_hostname"
  echo "$your_hostname" >/mnt/etc/hostname
  echo
}

# add packages and user
function setup_user() {
  echo "Add user peng..."
  local shell=""
  local yes_or_no="space"

  function ask_shell() {
    # read -p 'User name you want to add (peng): ' username
    # read -p 'Comment use for the new user(""): ' comment
    read -p 'Shell use for new user (default: bash | fish | zsh): ' shell
    # read -p 'Extra groups the new user will be added into("wheel,video,audio"): ' groups

    if [ $shell != "" ]; then
      case "$shell" in
      "bash")
        ;;
      "fish")
        packages="${packages} ${shell}"
        ;;
      "zsh")
        packages="${packages} ${shell}"
        ;;
      esac
    fi
  }

  while [ "$yes_or_no" != "" ]; do
    ask_shell
    echo "Installing packages:\n$packages"
    read -p "Press Enter to confirm, otherwise to re-choose? " yes_or_no
  done

  pacstrap -K /mnt $packages #>/dev/null 2>&1
  echo

  echo "Add user..."
  arch-chroot /mnt useradd -G wheel,video,audio -m -g users -s /usr/bin/${shell:-bash} \
    -p '$y$j9T$UQCNR6geVDFCK6KUsTzN51$JAZSQIeHhqY5l4lVt02.KJ53U0/a2DA4/0Dqj4PTtU/' ${username:-peng}
  echo
}

# change sudoer
function sudoer() {
  sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /mnt/etc/sudoers
}

# clone repo
function mv_repo() {
  echo "Move the repo to user's home..."
  myself=$(pwd)
  target=/mnt/home/${username:-peng}/.config
  cd ..
  mkdir -p $target
  cp -r "$myself" $target/dcli
  arch-chroot /mnt chown -R ${username:-peng}:users /home/${username:-peng}/.config
  cd $myself
  echo
}

# config the new system's pacman
function pacman_config_system() {
  cat <<'EOF' >/mnt/etc/pacman.conf
[options]
HoldPkg     = pacman glibc
Architecture = auto
CheckSpace
Color
VerbosePkgLists
ParallelDownloads = 10
DownloadUser = alpm
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Server = https://mirrors.cernet.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch

[extra]
Server = https://mirrors.cernet.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch

[archlinuxcn]
Server = https://mirrors.cernet.edu.cn/archlinuxcn/$arch
Server = https://mirrors.163.com/archlinux-cn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
EOF
}

# sync the system
function dcli_sync() {
  # arch-chroot -u ${usernmae:-peng} /mnt su -c "/home/${username:-peng}/.config/dcli/dcli sync" - ${username:-peng}
  arch-chroot /mnt su -c "/home/${username:-peng}/.config/dcli/dcli sync" - ${username:-peng}
}

# fstab
function gen_fstab() {
  genfstab -U /mnt >/mnt/etc/fstab
}

# chroot
function ch_root() {
  # arch-chroot -u ${username:-peng} /mnt su -c ${username:-peng}
  arch-chroot /mnt su - ${username:-peng}
}

function main() {
  mounted
  pacman_config
  install_pkgs
  setup_user
  setup_hostname
  sudoer
  gen_fstab
  mv_repo
  pacman_config_system
  # dcli_sync
  ch_root

  # change to the new system
  # arch-chroot -u ${username:-peng} /mnt bash -c "su - ${username:-peng}"
}

main
