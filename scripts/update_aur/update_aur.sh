#!/bin/bash

AUR_REPO="mostaqem" 
GITHUB_REPO="Mostaqem/mostaqem_desktop"
WORKDIR="$HOME/aur-$AUR_REPO"

rm -rf "$WORKDIR"
git clone ssh://aur@aur.archlinux.org/$AUR_REPO.git "$WORKDIR" || { echo "Failed to clone AUR repo"; exit 1; }
cd "$WORKDIR" || exit

LATEST_VERSION=$(curl -s "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | jq -r .tag_name | sed 's/^v//')

CURRENT_VERSION=$(grep -Po '(?<=pkgver=)[0-9.]+' PKGBUILD)
CURRENT_PKGREL=$(grep -Po '(?<=pkgrel=)[0-9]+' PKGBUILD)

if [[ "${LATEST_VERSION%.*}" != "${CURRENT_VERSION%.*}" ]]; then
  NEW_PKGREL=1
else
  NEW_PKGREL=$((CURRENT_PKGREL + 1))
fi

sed -i "s/^pkgver=.*/pkgver=$LATEST_VERSION/" PKGBUILD
sed -i "s/^pkgrel=.*/pkgrel=$NEW_PKGREL/" PKGBUILD
makepkg --printsrcinfo > .SRCINFO

git add PKGBUILD .SRCINFO
git commit -m "Update to version $LATEST_VERSION (pkgrel $NEW_PKGREL)"
git push
