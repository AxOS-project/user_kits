#!/bin/bash

set -e

OUTDIR="./out"
mkdir -p "$OUTDIR"

GREEN='\033[0;32m'
NC='\033[0m' # No Color

for dir in */; do
    [[ -f "${dir}/PKGBUILD" ]] || continue
    echo -e "${GREEN}==> Building package in $dir${NC}"
    pushd "$dir" > /dev/null
    makepkg -fcsd --noconfirm
    mv ./*.pkg.tar.zst "../$OUTDIR/"
    popd > /dev/null
done

echo -e "${GREEN}✅ All packages built and moved to $OUTDIR${NC}"
notify-send "All packages built" "All packages have been built and moved to $OUTDIR" -a "Sleex packages"
