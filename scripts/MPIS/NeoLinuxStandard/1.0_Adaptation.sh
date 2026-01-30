#!/bin/bash

sudo -v

echo "[1/5] 🔄 Система Обновляется... "
pacman -Syu --noconfirm

echo "[2/5] 📦 Установка Пакетов..."
sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf
curl -fsSL https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/pkglist.txt | sudo pacman -S --noconfirm -

echo "[3/5] 📦 Установка yay..."
mkdir -p /tmp/NeoLinux
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/NeoLinux/yay
  cd /tmp/NeoLinux/yay
  makepkg -si --noconfirm
  cd -
fi

echo "[4/5] 📦 Установка Пакетов из AUR..."
curl -fsSL https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/AURpkglist.txt | yay -S --noconfirm --answerdiff None --answeredit None -

echo "[5/5] 📦 Установка Пакетов из Flathub..."
curl -fsSL https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/FHpkglist.txt | xargs flatpak install -y --noninteractive

echo "[6/5] 🎨 Установка Тем и Иконок KDE... [1/3]"
git clone https://github.com/yeyushengfan258/Win11OS-kde /tmp/NeoLinux/Win11Theme
cd /tmp/NeoLinux/Win11Theme
chmod +x install.sh
./install.sh
cd -

echo "[6/5] 🎨 Установка Тем и Иконок KDE... [2/3]"
git clone https://github.com/yeyushengfan258/Win11-icon-theme /tmp/NeoLinux/Win11Icons
cd /tmp/NeoLinux/Win11Icons
chmod +x install.sh
./install.sh
cd -

echo "[6/5] 🎨 Установка Тем и Иконок KDE... [3/3]"
https://github.com/yeyushengfan258/We10X-icon-theme /tmp/NeoLinux/WeXIcons
cd /tmp/NeoLinux/WeXIcons
chmod +x install.sh
./install.sh
cd -

echo "[7/8] 🖥️ Настройка Kitty..."
mkdir -p ~/.config/kitty
curl -fsSL "https://raw.githubusercontent.com/K2254IVV/MASTERNUX/refs/heads/main/scripts/MPIS/NeoLinuxStandard/config.txt" -o ~/.config/kitty/kitty.conf

echo "[8/8] 🔓 Установка Zapret..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Snowy-Fluffy/zapret.installer/refs/heads/main/installer.sh)"

echo "✅ Установка Завршена Перезагрузите Систему!"
