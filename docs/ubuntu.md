# Setup a new (Ubuntu) machine

- Configure Bluetooth mouse
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

- Ubuntu Gnome Touch issue
```bash
sudo apt install xserver-xorg-input-libinput-hwe-16.04
sudo apt purge xserver-xorg-input-synaptics-hwe-16.04
```

- Set permanently switch Caps Lock and Esc
After starting the dconf-editor, navigate to org >> gnome >> desktop >> input-sources

Add `caps:swapescape` to the options that you need in xkb-options.
The option strings are surrounded by single quotes and separated by commas.
Be careful not to delete the brackets on the ends.

- Install Basic Tools:
`sudo apt install tmux git zsh curl xsel silversearcher-ag rxvt-unicode-256color wmctrl autojump`

- Install Oh-My-Zsh:  
Follow instructions here: https://github.com/robbyrussell/oh-my-zsh

- Install Vim 8:  
```bash
sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get install vim-gtk
```

- Install Vim-plug:  
Follow instructions here: https://github.com/junegunn/vim-plug

- Configure your .dotfiles:  
Follow instructions here: https://github.com/RafaelDelboni/dotfiles

- Fonts Source Code Pro
```bash
mkdir -p ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/SourceCodePro.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/SourceCodePro.zip
cd ~/.local/share/fonts
unzip SourceCodePro.zip
```

- Configure URxvt as Default Terminal:  
`gsettings set org.gnome.desktop.default-applications.terminal exec 'urxvt -e tmux new-session'`

- Install Firefox Developer Edition / Chromium
For Firefox Developer:
```bash
sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
sudo apt update
sudo apt upgrade
umake web firefox-dev
```

For chromium: `sudo apt-get install chromium-browser`

- Install Docker CE & Docker Compose
    1. Docker: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce  
      1.1. Add user to docker group: `sudo usermod -a -G docker $USER`
    2. Compose: https://docs.docker.com/compose/install/#prerequisites

- Install N (Node version manager):  
  `sudo curl -L https://git.io/n-install | bash`

- Install PHP and Composer
  1. PHP: 
    `sudo apt install \
    php7.0 \
    php7.0-curl \
    php7.0-json \
    php7.0-cgi \
    php7.0-fpm \
    php7.0-xml \
    autoconf \
    automake \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    openssl \
    gettext \
    libicu-dev \
    libmcrypt-dev \
    libmcrypt4 \
    libbz2-dev \
    libreadline-dev \
    build-essential \
    libmhash-dev \
    libmhash2 \
    libxslt1-dev
  `
  2. Composer:
      ```
      sudo curl -s https://getcomposer.org/installer | php
      sudo mv composer.phar /usr/local/bin/composer
      ```
- Install Virtual Box:  
Follow the "Debian-based Linux distributions": https://www.virtualbox.org/wiki/Linux_Downloads

- Install Redis:
Follow this: ttps://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04
