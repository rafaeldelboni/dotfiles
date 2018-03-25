# Arch Linux Setup

## Installation

### Load Keyboard Layout
```bash
loadKeys uk
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
useradd -m -G wheel -s /usr/bin/zsh rafael
passwd rafael
visudo
```
Uncomment this line: `%wheel ALL=(ALL) ALL`

### Network
```bash
echo alpha-arch > /etc/hostname
printf "\n127.0.0.1 localhost\n::1 localhost\n127.0.0.1 alpha-arch.localdomain alpha-arch" >> /etc/hosts
pacman -S dialog bluez bluez-utils networkmanager
systemctl enable NetworkManager.service
nmtui-connect
```

### Bootloader
```bash
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
mkdir /boot/efi/EFI/boot
cp /boot/efi/EFI/grub/grubx64.efi /boot/efi/EFI/boot/bootx64.efi
grub-mkconfig -o /boot/grub/grub.cfg
```

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

### Windows Manager and Apps
```bash
pacman -S xsel tmux arandr devmon tlp alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio acpi sysstat
pacman -S mesa xf86-video-intel
pacman -S nvidia nvidia-settings
pacman -S xorg-server xorg-xinit xorg-server-utils
pacman -S i3-gaps rofi i3lock i3blocks rxvt-unicode compton lxappearance
pacman -S libreoffice-writer libreoffice-calc zathura zathura-pdf-poppler imagemagick gimp playerctl pavucontrol ttf-font-awesome
yaourt -Sy rcm ttf-ms-fonts ttf-ubuntu-font-family nerd-fonts-source-code-pro xfce-theme-greybird
```
### Oh Ny Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

