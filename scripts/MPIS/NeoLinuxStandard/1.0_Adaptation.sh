#!/bin/bash

sudo -v
read -r cuser
if ! id "$cuser" &>/dev/null; then
  echo "❌ Пользователя $cuser не существует!"
  exit 1
fi

echo "[1/8] 🔄 Система Обновляется... "
sudo pacman -Syu --noconfirm

echo "[2/8] 📦 Установка Пакетов..."
sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf
sudo sed -i 's/^#\?ParallelDownloads.*/ParallelDownloads = 50/' /etc/pacman.conf
curl -fsSL https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/pkglist.txt | sudo pacman -S --noconfirm -

echo "[3/8] 📦 Установка yay..."
mkdir -p /tmp/NeoLinux && chmod 777 /tmp/NeoLinux
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/NeoLinux/yay
  cd /tmp/NeoLinux/yay
  sudo -u "$cuser" makepkg -si --noconfirm
  cd -
fi

echo "[4/8] 📦 Установка Пакетов из AUR..."
curl -fsSL https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/AURpkglist.txt | sudo -u "$cuser" yay -S --noconfirm --answerdiff None --answeredit None -

echo "[5/8] 📦 Установка Пакетов из Flathub..."
sudo flatpak remote-add --if-not-exists --noninteractive flathub https://dl.flathub.org/repo/flathub.flatpakrepo 
curl -fsSL https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/FHpkglist.txt | xargs sudo flatpak install -y --noninteractive

echo "[6/8] 🎨 Установка Тем и Иконок KDE... [1/3]"
git clone https://github.com/yeyushengfan258/Win11OS-kde /tmp/NeoLinux/Win11Theme
cd /tmp/NeoLinux/Win11Theme
chmod +x install.sh
sudo -u "$cuser" ./install.sh
cd -

echo "[6/8] 🎨 Установка Тем и Иконок KDE... [2/3]"
git clone https://github.com/yeyushengfan258/Win11-icon-theme /tmp/NeoLinux/Win11Icons
cd /tmp/NeoLinux/Win11Icons
chmod +x install.sh
sudo -u "$cuser" ./install.sh
cd -

echo "[6/8] 🎨 Установка Тем и Иконок KDE... [3/3]"
git clone https://github.com/yeyushengfan258/We10X-icon-theme /tmp/NeoLinux/WeXIcons
cd /tmp/NeoLinux/WeXIcons
chmod +x install.sh
sudo -u "$cuser" ./install.sh
cd -

echo "[7/8] 🖥️ Настройка Kitty..."
sudo -u "$cuser" mkdir -p /home/$cuser/.config/kitty
sudo -u "$cuser" curl -fsSL "https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/config.txt" -o /home/$cuser/.config/kitty/kitty.conf

echo "[8/8] 🖥️ Настройка Fastfetch..."
sudo -u "$cuser" mkdir -p /home/$cuser/.config/fastfetch
sudo -u "$cuser" curl -fsSL "https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/fastfetch.jsonc" -o /home/$cuser/.config/fastfetch/config.jsonc
sudo -u "$cuser" curl -fsSL "https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/icon.txt" -o /home/$cuser/.config/fastfetch/icon.txt

#echo "[9/9] 🔓 Установка Zapret..."
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/Snowy-Fluffy/zapret.installer/refs/heads/main/installer.sh)"

rm -rf /tmp/NeoLinux
echo "✅ Установка Завершена Перезагрузите Систему!"
