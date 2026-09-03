#!/usr/bin/env bash

set -e

echo "==> Instalando dependências básicas"

sudo apt update
sudo apt install -y \
    curl \
    git \
    zsh \
    unzip \
    build-essential

./common.sh
