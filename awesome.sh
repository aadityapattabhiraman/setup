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

packages=("rofi" "picom" "i3lock-fancy" "xclip" "ttf-roboto" "polkit-gnome" "materia-theme" "lxappearance" "flameshot" "pnmixer" "network-manager-applet" "xfce4-power-manager" "qt5-styleplugins" "papirus-icon-theme" "git")
yes | $aur_manager -S "${packages[@]}" -y

wget https://archive.archlinux.org/packages/a/awesome/awesome-4.3-3-x86_64.pkg.tar.zst
yes | sudo pacman -U awesome-4.3-3-x86_64.pkg.tar.zst
rm awesome-4.3-3-x86_64.pkg.tar.zst

echo "Packages installed successfully. Cloning repository..."
git clone https://github.com/aadityapattabhiraman/awesomwm ~/.config/awesome

echo "Repository cloned successfully. Configuring Rofi..."
mkdir -p ~/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi ~/.config/rofi/config.rasi
sed -i '/@import/c\@import "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi

echo "Same theme for Qt/KDE applications and GTK applications, and fix missing indicators"
echo "XDG_CURRENT_DESKTOP=Unity" >> /etc/environment
echo "QT_QPA_PLATFORMTHEME=gtk2" >> /etc/environment