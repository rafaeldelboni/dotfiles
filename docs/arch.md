# Arch Linux Setup

## Installation
You can download this raw file using `wget bit.ly/rdarchdocs`

### Wireless on Installation
The command `iw dev` gives the interface name (`wlp2s0` in the exaple)
to use in the following commands:
```bash
wpa_supplicant -B -i wlp2s0 -c <(wpa_passphrase "the network SSID" "wpa passkey")
dhcpcd wlp2s0

# or

wifi-menu
```

### Load Keyboard Layout
```bash
loadkeys uk
```

### Partition the disks

Check available SSDs

```bash
fdisk -l
```

#### Scheme

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

### Format partitions

Boot partition:
```bash
mkfs.fat -F32 /dev/sda1
```

Swap partition:
```bash
mkswap /dev/sda2
swapon /dev/sda2
```

Data partition:
```bash
mkfs.ext4 /dev/sda3
```

### Mount partitions

```bash
mount /dev/sda3 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

### Install the base packages

Select the best mirror
```bash
vim /etc/pacman.d/mirrorlist
```

```bash
pacstrap /mnt base base-devel linux linux-firmware neovim zsh
genfstab -U /mnt >> /mnt/etc/fstab
```

### Locale

```bash
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc
printf "\nen_US.UTF-8 UTF-8\npt_BR.UTF-8 UTF-8\n" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

### Default text editor

```
export VISUAL="vim"
export EDITOR="$VISUAL"
```

### User

```bash
passwd
useradd -m -G wheel,storage,power,audio,video -s /usr/bin/zsh rafael
passwd rafael
visudo
```
Uncomment this line: `%wheel ALL=(ALL) ALL`

### Network
```bash
echo alpha-arch > /etc/hostname
printf "\n127.0.0.1 localhost\n::1 localhost\n127.0.0.1 alpha-arch.localdomain alpha-arch" >> /etc/hosts
pacman -S dialog bluez bluez-utils networkmanager wireless_tools
systemctl enable NetworkManager.service
```
To connect to network after the reboot use `nmtui-connect` 

### Bootloader
```bash
pacman -S grub efibootmgr ntfs-3g os-prober
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
mkdir /boot/efi/EFI/boot
cp /boot/efi/EFI/grub/grubx64.efi /boot/efi/EFI/boot/bootx64.efi
grub-mkconfig -o /boot/grub/grub.cfg
vim /boot/grub/grub.cfg
```
Add the following kernel startup parameters on `/etc/default/grub`:
```
  GRUB_CMDLINE_LINUX_DEFAULT="acpi_osi=! acpi_osi=\"Windows 2009\" nvidia-drm.modeset=1 quiet loglevel=0 vga=current"
```

### Audio & Video
```bash
pacman -S alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio
pacman -S xorg-server xorg-xinit xorg-apps xf86-input-evdev
pacman -S nvidia nvidia-utils nvidia-settings
```

### Windows Manager (i3)
```bash
pacman -S i3-gaps i3blocks i3lock rofi compton alacritty tmux lxappearance
```
Some basic fonts
```
  pacman -S ttf-dejavu ttf-font-awesome adobe-source-han-sans-otc-fonts ttf-indic-otf
```
Create the file `.xinitrc` file
```
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
exec i3
```
Run `startx`

### Yaourt
```bash
pacman -S git
mkdir ~/Sources
cd ~/Sources
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
yaourt -Syu --devel --aur
```

### Apps
```bash
pacman -S ranger xfce4-notifyd feh imagemagick w3m gimp playerctl xsel arandr devmon tlp acpi sysstat libmpdclient openssh the_silver_searcher scrot zsh-autosuggestions
yaourt -Sy rcm autojump ttf-ms-fonts ttf-ubuntu-font-family nerd-fonts-source-code-pro xfce-theme-greybird acpilight xtitle-git
```

### Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### Bumblebee
Bumblebee is the best way to minimize battery usage and selective usage of GPU
https://wiki.archlinux.org/index.php/bumblebee
```bash
pacman -Sy xf86-video-intel mesa bumblebee bbswitch
gpasswd -a rafael bumblebee
systemctl enable bumblebeed.service
systemctl start bumblebeed.service
```

### TLP
To complete TLP's install, you must enable the systemd services `tlp.service` and `tlp-sleep.service`. You should also mask the systemd service `systemd-rfkill.service` and socket `systemd-rfkill.socket` to avoid conflicts and assure proper operation of TLP's radio device switching options.
```bash
sudo systemctl enable tlp
sudo systemctl start tlp
sudo systemctl enable tlp-sleep
sudo systemctl start tlp-sleep
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
```

#### TLP vs Bumblebee with NVIDIA driver
If you're running Bumblebee with NVIDIA driver, you need to disable power management for the GPU in TLP in order to make Bumblebee control the power of the GPU.
Run `lspci` to determine the address of the GPU (such as 01:00.0), then set the value in the top config file `/etc/default/tlp`:
```
 RUNTIME_PM_BLACKLIST="01:00.0"
```

### acpilight / xbacklight
Normally, users are prohibited to alter files in the sys filesystem. It's
advisable (and recommended) to setup an "udev" rule to allow users in the
"video" group to set the display brightness.
To do so, place a file in /etc/udev/rules.d/90-backlight.rules containing:
```
SUBSYSTEM=="backlight", ACTION=="add", \
  RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness", \
  RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
```

### Touchpad
Make sure your touchpad config `/usr/share/X11/xorg.conf.d/40-libinput.conf` is like this:
```
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
        Option "NaturalScrolling" "true"
EndSection
```

### Blutooth Mouse (MX Anywhere 2S)
```
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

### Dotfiles
Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone --recurse-submodules git@github.com:rafaeldelboni/dotfiles.git .dotfiles
$ rcup -x docs -x readme.md
$ xrdb ~/.Xresources
```

`rcup` expects that you cloned your dotfiles to `~/.dotfiles/` and will create dotfile symlinks (`.vimrc` -> `~/.dotfiles/vimrc`) from your home directory to your `~/.dotfiles/` directory.

`xrdb ~/.Xresources` sync the Xresources file with your current XServer

### Installing Vim Plugins
To install them you'll need [vim-plug](https://github.com/junegunn/vim-plug), as mentioned above.
Once Plug is installed. Open vim (`$ vim`) and type `:PlugInstall`. And then restart vim. You'll need to do this for all the plugins to work.

### Installing Tmux Plugins
[tmux-plugins](https://github.com/tmux-plugins/tpm)
Once installed press `prefix` + <kbd>I</kbd> (capital I, as in **I**nstall) to fetch the plugin.

### GPG
```bash
pacman -Sy gnupg pinentry
gpg --import backuped-gpg.asc
gpg-connect-agent reloadagent /bye
```

### Set AltGr+HJKL to Arrows
Change the files `/usr/share/X11/xkb/symbols/us` and `/usr/share/X11/xkb/symbols/gb` in the sessions `intl` and `extd` respectively, as the example below:

```
    key <AC06> { [	   h,          H,          Left,             Left ] };
    key <AC07> { [	   j,          J,          Down,             Down ] };
    key <AC08> { [	   k,          K,            Up,               Up ] };
    key <AC09> { [	   l,          L,         Right,            Right ] };
```

### Set Login Screen Issue
```
  sudo cp /etc/issue /etc/issue.bkp
  sudo cp ~/.config/issue /etc/issue
```
