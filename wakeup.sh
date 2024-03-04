#!/bin/bash
###################################################################
# Script Name: wakeup.sh
# Description: Follow the white rabbit.
# Date: 21/10/2022
# Author: @kahledrahaus
# Encode: UTF8
###################################################################

clear
test $(which pv) || {
    echo -e "Erro: Pacote 'pv' requerido, use:\nsudo apt-get install -y pv"
    exit 1
}

wakeup=("Wake up, Neo..."
    "The Matrix has you..."
    "Follow the white rabbit."
    "Knock, Knock, Neo."
)

for i in "${wakeup[@]}"; do
    echo -en "\033[1;32m$i" | pv -qL 15
    sleep 3
    clear
done
