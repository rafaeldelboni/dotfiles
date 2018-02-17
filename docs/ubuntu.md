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

- Set permanently switch Caps Lock and Esc
After starting the dconf-editor, navigate to org >> gnome >> desktop >> input-sources

Add `caps:swapescape` to the options that you need in xkb-options.
The option strings are surrounded by single quotes and separated by commas.
Be careful not to delete the brackets on the ends.

- Install Basic Tools:
`sudo apt install tmux git zsh curl xsel unity-tweak-tool dconf-tools silversearcher-ag rxvt-unicode-256color wmctrl`

- Install Oh-My-Zsh:  
Follow instructions here: https://github.com/robbyrussell/oh-my-zsh

- Install Vim 8:  
`sudo apt-get install vim-gtk`

- Install Vim-plug:  
Follow instructions here: https://github.com/junegunn/vim-plug

- Configure your .dotfiles:  
Follow instructions here: https://github.com/RafaelDelboni/dotfiles

- Configure URxvt as Default Terminal:  
`sudo update-alternatives --config x-terminal-emulator`

- Install Firefox Developer Edition / Chromium
  1. Download from Mozilla Firefox Developer Edition webpage.
  2. Extract it with file-roller and move the folder to its final location.
  3. A good practice is to install it in /opt/ or /usr/local/.
  4. Once you moved the files to their final location (say /opt/firefox_dev/),  
     you can create the following file ~/.local/share/applications/firefox_dev.desktop  
     to get a launcher with an icon distinct from normal Firefox.

        ```
        [Desktop Entry]
        Name=Firefox Developer 
        GenericName=Firefox Developer Edition
        Exec=/opt/firefox_dev/firefox %u
        Terminal=false
        Icon=/opt/firefox_dev/browser/icons/mozicon128.png
        Type=Application
        Categories=Application;Network;X-Developer;
        Comment=Firefox Developer Edition Web Browser.
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
