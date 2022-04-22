# Arch Linux Setup

## Installation
You can download this raw file using `wget bit.ly/rdarchdocs`

## Wireless on Installation
Use the command `iwctl` to get an interactive prompt.
> In the iwctl prompt you can auto-complete commands, device names and SSID by hitting Tab.

First, if you do not know your wireless device name, list all Wi-Fi devices:
```bash
[iwd]# device list
```
If the command above don't list any wifi card you can try the following: `rfkill unblock all` and try again.

Then, to scan for networks:
```bash
[iwd]# station device scan
```

You can then list all available networks:
```bash
[iwd]# station device get-networks
```

Finally, to connect to a network:
```bash
[iwd]# station device connect SSID
```

## Partition the disks

Check available SSDs

```bash
fdisk -l
```

### Scheme

| Name      | Size        | System |
| --------- |:-----------:|:------:|
| /boot/efi | 512MB       | fat    |
| swap      | 2x RAM      | swap   |
| /         | All Rest    | ext4   |

```bash
parted /dev/sda

(parted) mklabel gpt
(parted) mkpart ESP fat32 1M 513M
(parted) set 1 boot on
(parted) mkpart primary linux-swap 513M 32G
(parted) mkpart primary ext4 32G 100%
(parted) quit

lsblk /dev/sda
```

## Encrypt: Start

```bash
cryptsetup luksFormat --type luks2 /dev/sda3
cryptsetup open /dev/sda3 cryptlvm
```

## Encrypt: LVM setup
```bash
pvcreate /dev/mapper/cryptlvm
vgcreate cryptvg /dev/mapper/cryptlvm
lvcreate -l 100%FREE cryptvg -n root
```

## Format partitions

Boot partition:
```bash
mkfs.fat -F32 /dev/sda1
```

Swap partition:
```bash
mkswap /dev/sda2
swapon /dev/sda2
```

Data encrypted partition:
```bash
mkfs.ext4 /dev/cryptvg/root
```

## Mount partitions

```bash
mount /dev/cryptvg/root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

## Install the base packages

Select the best mirror
```bash
vim /etc/pacman.d/mirrorlist
```

```bash
pacstrap /mnt base base-devel linux linux-firmware neovim zsh
genfstab -U /mnt >> /mnt/etc/fstab
```

## Locale

```bash
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
printf "\nen_US.UTF-8 UTF-8\npt_BR.UTF-8 UTF-8\n" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
systemctl enable systemd-timesyncd.service
```

## Default text editor

```
export VISUAL="nvim"
export EDITOR="$VISUAL"
```

## User

```bash
passwd
useradd -m -G wheel,storage,power,audio,video -s /usr/bin/zsh rafael
passwd rafael
visudo
```
Uncomment this line: `%wheel ALL=(ALL) ALL`

## Network
```bash
echo alpha-arch > /etc/hostname
printf "\n127.0.0.1 localhost\n::1 localhost\n127.0.0.1 alpha-arch.localdomain alpha-arch" >> /etc/hosts
pacman -S dialog bluez bluez-utils networkmanager wireless_tools
systemctl enable NetworkManager.service
```
To connect to network after the reboot use `nmtui-connect` 

## Encrypt: Generate an initramfs
Edit `/etc/mkinitcpio.conf` so we can generate an initramfs which lets us decrypt our root partition during start-up.
Change the HOOKS definition to look like this:
```
HOOKS=(base systemd udev keyboard autodetect sd-vconsole modconf block sd-encrypt lvm2 filesystems fsck)
```

We have to create an `/etc/crypttab.initramfs` to identify our encrypted volume.
Linux uses UUIDs to uniquely identify your data volumes, independent of the system they’re attached to.

Let’s figure out the UUID of our encrypted partition:
```bash
ls -l /dev/disk/by-uuid | grep sda3
```

Copy the UUID and edit `/etc/crypttab.initramfs`:
```
cryptlvm UUID=<your UUID> none luks2,discard
```

We can edit /etc/vconsole.conf to define the keyboard layout used for entering our encryption passphrase during start-up:
```
KEYMAP=us
```

Let’s generate a new initramfs image that contains everything we need for decrypting our volume:
```bash
pacman -S lvm2
mkinitcpio -p linux
```

## Bootloader
```bash
bootctl install
```
### Encrypt: Bootloader setup
We will have to tell the boot loader which root partition to boot from.
Look at your `cat /etc/fstab` and copy the UUID of your root filesystem.
> **Note that this is a different UUID than the one we used before!**

Edit `/boot/loader/entries/arch.conf` and add the following lines:
```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=<your UUID> rw quiet loglevel=0 splash
```
Edit `/boot/loader/loader.conf` and uncomment `timeout`
in case you want the boot menu to show up.

## Audio & Video
```bash
pacman -S alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio
pacman -S xorg-server xorg-xinit xorg-apps xf86-input-evdev
```

### Intel Video (Old Cards)
```bash
pacman -S mesa xf86-video-intel vulkan-intel
```
In case `startx` doesn't work, add file `/usr/share/X11/xorg.conf.d/20-intel.conf` with the following contents:
```
Section "Device"
        Identifier "Intel Graphics"
        Driver     "intel"
        Option     "Virtualheads 3"
EndSection
```

### Intel Video (New Cards, Eg. Iris XE)
```bash
pacman -S mesa intel-media-driver vulkan-intel
```
You also need to add `i915.enable_guc=2` kernel argument into `/boot/loader/entries/arch.conf` options.

### Nvidia Cards
```bash
pacman -S nvidia nvidia-utils nvidia-settings
```
You also need to add `acpi_osi=! acpi_osi=\"Windows 2009\" nvidia-drm.modeset=1` kernel arguments into `/boot/loader/entries/arch.conf` options.

## Windows Manager (i3)
```bash
pacman -S i3-gaps i3blocks rofi picom alacritty tmux lxappearance
```
Some basic fonts
```
pacman -S ttf-dejavu ttf-font-awesome adobe-source-han-sans-otc-fonts ttf-indic-otf noto-fonts-emoji
```
Create the file `.xinitrc` file
```
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
exec i3
```
Run `startx`

# Config

## Yay
```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Apps
```bash
pacman -S zsh-completions xdg-utils fzf xfce4-notifyd feh imagemagick w3m gimp playerctl xclip arandr tlp acpi sysstat libmpdclient openssh ripgrep maim zsh-autosuggestions acpilight zip unzip
yay -Sy i3lock-color rcm autojump-rs ttf-ms-fonts ttf-ubuntu-font-family nerd-fonts-jetbrains-mono xfce-theme-greybird xtitle-git babashka-bin --noconfirm
```

## Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## GPG
```bash
pacman -Sy gnupg pinentry
gpg --import backuped-gpg.asc
gpg-connect-agent reloadagent /bye
```

## Dotfiles
Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```bash
cd
git clone git@github.com:rafaeldelboni/dotfiles.git .dotfiles
rcup -x docs -x readme.md
xrdb ~/.Xresources
```

`rcup` expects that you cloned your dotfiles to `~/.dotfiles/` and will create dotfile symlinks (`.vimrc` -> `~/.dotfiles/vimrc`) from your home directory to your `~/.dotfiles/` directory.

`xrdb ~/.Xresources` sync the Xresources file with your current XServer

## Installing Tmux Plugin
[tmux-plugins](https://github.com/tmux-plugins/tpm)
Once installed press `prefix` + <kbd>I</kbd> (capital I, as in **I**nstall) to fetch the plugin.

## TLP
To complete TLP's install, you must enable the systemd services `tlp.service` and `tlp-sleep.service`. You should also mask the systemd service `systemd-rfkill.service` and socket `systemd-rfkill.socket` to avoid conflicts and assure proper operation of TLP's radio device switching options.
```bash
sudo systemctl enable tlp
sudo systemctl start tlp
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
```

## acpilight / xbacklight
Normally, users are prohibited to alter files in the sys filesystem. It's
advisable (and recommended) to setup an "udev" rule to allow users in the
"video" group to set the display brightness.
To do so, place a file in /etc/udev/rules.d/90-backlight.rules containing:
```bash
SUBSYSTEM=="backlight", ACTION=="add", \
  RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness", \
  RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
```

## Touchpad and Slimblade
Make sure you link the following files:
```bash
sudo ln -sf ~/.xorg/10-touchpad.conf /usr/share/X11/xorg.conf.d/10-touchpad.conf
sudo ln -sf ~/.xorg/10-slimblade.conf /usr/share/X11/xorg.conf.d/10-slimblade.conf
```

## Blutooth Mouse (MX Anywhere 2S)
```bash
  bluetoothctl
  [bluet]power off
  [bluet]power on
  [bluet]scan on
  [mouse]connect XX:XX:XX:XX:XX:XX
  [mouse]trust
  [mouse]connect XX:XX:XX:XX:XX:XX
  [mouse]pair
  [mouse]unblock
  [mouse]power off
  [bluet]power on
```
Now you just need to add the line AutoEnable=true in /etc/bluetooth/main.conf at the bottom in the [Policy] section:
```
[Policy]
AutoEnable=true
```

## Set local enviroment settings
Create the following file `~/.local-env`
```bash
export LOCAL_DPI="96"
export LOCAL_MODE="2560x1440"
export LOCAL_DPI_FACTOR=1.4
```

## Bumblebee
Bumblebee is the best way to minimize battery usage and selective usage of GPU
https://wiki.archlinux.org/index.php/bumblebee
```bash
pacman -Sy bumblebee bbswitch
gpasswd -a rafael bumblebee
systemctl enable bumblebeed.service
systemctl start bumblebeed.service
```

In some instances, running optirun will return:
```
[ERROR]Cannot access secondary GPU - error: [XORG] (EE) No devices detected.
[ERROR]Aborting because fallback start is disabled.
```
You might need to define the NVIDIA card in the file `/etc/bumblebee/xorg.conf.nvidia`, using the correct BusID according to lspci output
```
    BusID "PCI:01:00:0"
```

### TLP vs Bumblebee with NVIDIA driver
If you're running Bumblebee with NVIDIA driver, you need to disable power management for the GPU in TLP in order to make Bumblebee control the power of the GPU.
Run `lspci` to determine the address of the GPU (such as 01:00.0), then set the value in the top config file `/etc/default/tlp`:
```
 RUNTIME_PM_BLACKLIST="01:00.0"
```
