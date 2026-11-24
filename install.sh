#!/bin/sh
set -eu

SRC=$(cd "$(dirname "$0")" && pwd)
CFG=${XDG_CONFIG_HOME:-$HOME/.config}

[ "$(id -u)" -eq 0 ] && { echo "run as your user, not root" >&2; exit 1; }

command -v pacman >/dev/null 2>&1 && PKG="sudo pacman -S --needed --noconfirm"
[ -z "${PKG:-}" ] && command -v emerge >/dev/null 2>&1 && PKG="sudo emerge --noreplace"
[ -z "${PKG:-}" ] && command -v xbps-install >/dev/null 2>&1 && PKG="sudo xbps-install -y"
[ -z "${PKG:-}" ] && command -v apk >/dev/null 2>&1 && PKG="sudo apk add"
[ -z "${PKG:-}" ] && command -v apt-get >/dev/null 2>&1 && PKG="sudo apt-get install -y"
[ -z "${PKG:-}" ] && PKG="false"

for p in bat eza fd fish foot fzf git starship tmux yazi zoxide; do
    command -v "$p" >/dev/null 2>&1 || $PKG "$p" 2>/dev/null || true
done

link() {
    mkdir -p "$(dirname "$2")"
    if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak"; fi
    ln -sfn "$1" "$2"
}

for d in atuin bat btop fastfetch fish foot fzf gtk-3.0 gtk-4.0 niri noctalia yazi; do
    (cd "$SRC/$d" && find . -type f) | while read -r f; do
        f=${f#./}
        link "$SRC/$d/$f" "$CFG/$d/$f"
    done
done

for m in yazi nadia zellij; do
    [ -d "$SRC/$m" ] || continue
    (cd "$SRC/$m" && find . -type f) | while read -r f; do
        f=${f#./}
        link "$SRC/$m/$f" "$CFG/$m/$f"
    done
done

link "$SRC/bash/.bashrc" "$HOME/.bashrc"
link "$SRC/bash/.bash_profile" "$HOME/.bash_profile"
link "$SRC/git/.gitconfig" "$HOME/.gitconfig"

chmod +x "$CFG/noctalia/hooks/nagi-battery.sh" 2>/dev/null || true

if [ -d /etc/portage ]; then
    sudo cp "$SRC/make.conf" /etc/portage/make.conf
fi

echo "installed"
