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
> Note that you need to reuse the Windows boot partition if dual booting in the same SSD.

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
pacstrap /mnt base base-devel linux linux-firmware neovim zsh git 
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
pacman -S dialog bluez bluez-utils networkmanager wireless_tools network-manager-applet
systemctl enable NetworkManager.service
```
To connect to network after the reboot use `nmtui-connect` 

## Encrypt: Generate an initramfs
Edit `/etc/mkinitcpio.conf` so we can generate an initramfs which lets us decrypt our root partition during start-up.
Change the HOOKS definition to look like this:
```
HOOKS=(base systemd udev keyboard autodetect modconf block sd-encrypt lvm2 filesystems fsck)
```
Ensure **systemd, sd-encrypt and lvm2** are on the HOOKS list. 

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

## Tools
```bash
pacman -S zsh-autosuggestions curl tmux openssh zip unzip ripgrep fzf xclip jq rustup 
```

### Installing Tmux Plugin
[tmux-plugins](https://github.com/tmux-plugins/tpm)
Once installed press `prefix` + <kbd>I</kbd> (capital I, as in **I**nstall) to fetch the plugin.

### Enable ssh-agent.service
```bash
systemctl --user enable ssh-agent.service
```

## Audio
```bash
pacman -S alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio playerctl
```

## Video
```bash
pacman -S xorg-server xorg-apps xorg-xinit
```

### Intel Driver (New Cards, Eg. Iris XE)
```bash
pacman -S mesa mesa-utils vulkan-intel
```
You also need to add `i915.enable_guc=2` kernel argument into `/boot/loader/entries/arch.conf` options.

### Nvidia Driver
```bash
pacman -S nvidia nvidia-utils nvidia-settings nvidia-prime
```
You also need to add `acpi_osi=\"Windows 2015\" nvidia-drm.modeset=1` kernel arguments into `/boot/loader/entries/arch.conf` options.

## Windows Manager (i3)
```bash
pacman -S i3 picom rofi alacritty xdg-utils lxappearance xfce4-notifyd feh maim
```

Some basic fonts
```bash
pacman -S ttf-dejavu ttf-font-awesome adobe-source-han-sans-otc-fonts ttf-indic-otf noto-fonts-emoji
```

Create the file `.Xresources`
```
Xft.dpi: 144
```

Create the file `.xinitrc`
```bash
xrdb -merge $HOME/.Xresources
xrandr --dpi 144 --auto
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

## Aur Tools
```bash
yay -Sy autojump-rs ttf-jetbrains-mono-nerd xfce-polkit nordic-theme --noconfirm
```

## Paro
```bash
bash < <(curl -s https://raw.githubusercontent.com/rafaeldelboni/paro/main/install.sh)
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
rcup -x docs -x readme.md -t linux
```
`rcup` expects that you cloned your dotfiles to `~/.dotfiles/` and will create dotfile symlinks (`.vimrc` -> `~/.dotfiles/vimrc`) from your home directory to your `~/.dotfiles/` directory.


## TLP
To a complete TLP's install, you must enable the systemd services `tlp.service` and `tlp-sleep.service`. You should also mask the systemd service `systemd-rfkill.service` and socket `systemd-rfkill.socket` to avoid conflicts and assure proper operation of TLP's radio device switching options.
```bash
pacman -S tlp tlp-rdw

sudo systemctl enable tlp
sudo systemctl start tlp
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
```

Edit the TLP config `/etc/tlp.conf` file and enable wifi and blutooth on the system startup.

Add the following line:
```
DEVICES_TO_ENABLE_ON_STARTUP="wifi bluetooth"
```

## Touchpad and Trackballs
Make sure you link the following files:
```bash
sudo ln -sf ~/.xorg/10-touchpad.conf /usr/share/X11/xorg.conf.d/10-touchpad.conf
sudo ln -sf ~/.xorg/10-slimblade.conf /usr/share/X11/xorg.conf.d/10-slimblade.conf
sudo ln -sf ~/.xorg/10-expert-mouse.conf /usr/share/X11/xorg.conf.d/10-expert-mouse.conf
```

## Blutooth
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

### GUI
You can install `blueman` for a visual blutooth applet

### Dual boot & ZMK bluetooth device
A quick guide on getting an ZMK bluetooth based device to connect to linux and windows when dual booting on a single machine.  
https://hoelter.prose.sh/kinesis-advantage-360-bluetooth-dualboot
