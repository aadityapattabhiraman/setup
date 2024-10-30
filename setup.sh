#!/usr/bin/env sh

mkdir Programs/
cd Programs/

# Installing Brave
echo "Cloning & Installing Brave Binary Package"
git clone https://aur.archlinux.org/brave-bin.git
cd brave-bin/
makepkg -si
cd ..

# Installing qt5-styleplugins
echo "Cloning & Installing qt5-styleplugins Package"
git clone https://aur.archlinux.org/qt5-styleplugins.git
cd qt5-styleplugins/
makepkg -si
cd ..

# Installing pnmixer
echo "Cloning and Installing pnmixer Package"
git clone https://aur.archlinux.org/pnmixer.git
cd pnmixer/
makepkg -si
cd ..

# Installing i3lock-fancy
echo "Cloning and Installing 13lock-fancy-git Package"
git clone https://aur.archlinux.org/i3lock-fancy-git.git
cd i3lock-fancy-git/
makepkg -si
cd ..

# Installing Tor Browser
echo "Cloning & Installing tor-browser Binary Package"
git clone https://aur.archlinux.org/tor-browser-bin.git
cd tor-browser-bin/
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org
makepkg -si
cd ..

# Installing Element-Nightly Desktop
echo "Cloning & Installing Element-Nightly Binary Package."
git clone https://aur.archlinux.org/element-desktop-nightly-bin.git
cd element-nightly-desktop-bin/
makepkg -si
cd

# Installing Necessary Packages for AwesomeWM
echo "Installing Necessary Packages for my AwesomeWM Config"
sudo pacman -S rofi picom xclip ttf-roboto polkit-gnome materia-theme lxappearance flameshot xfce4-power-manager papirus-icon-theme awesome dunst variety feh terminator thunar
echo "Finished Installing All the Necessary Packages"

# Cloning config
echo "Cloning AwesomeWM Config"
git clone https://github.com/aadityapattabhiraman/awesomwm ~/.config/awesome

# Configuring Rofi
echo "Configuring Rofi Theme"
mkdir -p ~/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi ~/.config/rofi/config.rasi
sed -i '/@import/c\@import "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi

# Applying same Theme for Applications
echo "XDG_CURRENT_DESKTOP=Unity" | sudo tee -a /etc/environment
echo "QT_QPA_PLATFORMTHEME=gtk2" | sudo tee -a /etc/environment

# Configuring Dunst
echo "Configuring Dunst"
mkdir -p ~/.config/dunst/
# Create the dunstrc file and add the configuration
cat > ~/.config/dunst/dunstrc << EOF
# Dunst Configuration File

# Global Settings
[global]
    font = Monospace 12
    origin = bottom-left
    line_height = 4
    padding = 8
    sort = yes
    offset = 20x25
    width = 500
    shrink = yes
    frame_color = "#000000"
    frame_width = 0


# Urgency Settings
[urgency_low]
    # Background color
    background = "#000000"
    # Foreground color
    foreground = "#00FF00"
    # Timeout
    timeout = 5


[urgency_normal]
    background = "#2f343f"
    foreground = "#d3dae3"
    timeout = 20


[urgency_critical]
    background = "#ff3030"
    foreground = "#ffffff"
    timeout = 0


# Custom Notification Format
[format]
    format = "<b>%s</b>\n%b"
EOF

echo "Configuration for Awesomewm Completed."

# Themeing GRUB
echo "Cloning BootLoader Themes & Installing it."
cd Programs/
git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd Top-5-Bootloader-Themes
sudo ./install.sh
cd
