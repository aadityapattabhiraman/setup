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

$aur_manager -S lutris wine winetricks
sudo systemctl restart systemd-binfmt
$aur_manager -S lib32-nvidia-utils dxvk-bin
