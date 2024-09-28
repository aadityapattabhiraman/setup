#!/bin/bash

aur_manager=""
if command -v yay &> /dev/null; then
  aur_manager="yay"
elif command -v trizen &> /dev/null; then
  aur_manager="trizen"
elif command -v pacaur &> /dev/null; then
  aur_manager="pacaur"
elif command -v pamac &> /dev/null; then
  aur_manager="pamac"
elif command -v pikaur &> /dev/null; then
  aur_manager="pikaur"
fi

if [ -z "$aur_manager" ]; then
  echo "No AUR manager found. Please install one first."
  exit 1
fi

packages=("rofi" "picom" "i3lock-fancy" "xclip" "ttf-roboto" "polkit-gnome" "materia-theme" "lxappearance" "flameshot" "pnmixer" "network-manager-applet" "xfce4-power-manager" "qt5-styleplugins" "papirus-icon-theme" "git" "awesome" "dunst")
yes | $aur_manager -S "${packages[@]}" -y

echo "Packages installed successfully. Cloning repository..."
git clone https://github.com/aadityapattabhiraman/awesomwm ~/.config/awesome

echo "Repository cloned successfully. Configuring Rofi..."
mkdir -p ~/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi ~/.config/rofi/config.rasi
sed -i '/@import/c\@import "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi

echo "Same theme for Qt/KDE applications and GTK applications, and fix missing indicators"
echo "XDG_CURRENT_DESKTOP=Unity" >> /etc/environment
echo "QT_QPA_PLATFORMTHEME=gtk2" >> /etc/environment

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

echo "Dunst configuration file created successfully."