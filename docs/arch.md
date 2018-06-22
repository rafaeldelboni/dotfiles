# Arch Linux Setup

## Installation
You can download this raw file using `wget bit.ly/rdarchdocs`

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
pacstrap /mnt base base-devel vim zsh
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

### User
```bash
passwd
useradd -m -G wheel,storage,power -s /usr/bin/zsh rafael
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
  GRUB_CMDLINE_LINUX_DEFAULT="acpi_osi=! acpi_osi=\"Windows 2009\" nvidia-drm.modeset=1 quiet"
```

### Audio & Video
```bash
pacman -S alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio
pacman -S xorg-server xorg-xinit xorg-apps
pacman -S nvidia nvidia-utils nvidia-settings
```

### Windows Manager (i3)
```bash
pacman -S i3-gaps rofi compton rxvt-unicode lxappearance
pacman -S ttf-dejavu ttf-font-awesome
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
pacman -S ranger feh imagemagick gimp playerctl xsel tmux arandr devmon tlp acpi sysstat libmpdclient openssh the_silver_searcher scrot
yaourt -Sy rcm polybar ttf-ms-fonts ttf-ubuntu-font-family nerd-fonts-source-code-pro xfce-theme-greybird acpilight
```

### Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### Bumblebee
Bumblebee is the best way to minimize battery usage and selective usage of GPU
https://wiki.archlinux.org/index.php/bumblebee

### Touchpad
Make sure your touchpad config `/usr/share/X11/xorg.conf.d/40-libinput.con` is like this:
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
