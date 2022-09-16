#!/bin/bash

function setup() {
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    wget -O ~/.ssh/authorized_keys https://github.com/qazxcdswe123.keys
    chmod 600 ~/.ssh/authorized_keys
}

function ssh_config() {
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
    sed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
    sudo systemctl restart sshd
}

function main() {
    setup
    ssh_config
}

