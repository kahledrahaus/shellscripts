#!/bin/bash
########################################################################################
# Nome do Script: finder.sh
# Descrição: Escaneando subdomínios e subdiretórios em sites usando curl
# Autor: https://github.com/kahledrahaus
# Data: 17/11/2021
# Dependências: curl, pv
# Codificação: UTF8
########################################################################################

# Regular             Bold
Warning='\e[0;31m';   BWarning='\e[1;31m';
Alert='\e[0;33m';     BAlert='\e[1;33m';
Gre='\e[0;32m';       BGre='\e[1;32m';

SCRIPT=${0##*/}
# Verifique se o 'curl' e o 'pv' estão instalados
test $(which curl) || { echo -e "${SCRIPT}: pacote 'curl' necessário, use: sudo apt-get install -y curl"; exit 1; }
test $(which pv)   || { echo -e "${BWarning}${SCRIPT}: pacote 'pv' necessário, use: sudo apt-get install -y pv"; exit 1; }

banner() {

    cat << 'EOF'
 _____ ___ _   _ ____  _____ ____  
|  ___|_ _| \ | |  _ \| ____|  _ \ 
| |_   | ||  \| | | | |  _| | |_) |
|  _|  | || |\  | |_| | |___|  _ < 
|_|   |___|_| \_|____/|_____|_| \_\ 
                       
        V. 1.0 Por: kahledrahaus                                                 
EOF

}

_help() {
    clear;echo -e "${BGre}$(banner)\n"
    [[ -z $dominio ]] && echo -e "${BAlert}Domínio não informado!${BGre}"
    [[ -z $wordlist ]] && echo -e "${BAlert}Wordlist não informada!${BGre}"
	cat <<EOF

Use: ${SCRIPT} [opção] [argumentos]
Opções:
    --subdominios dominio wordlist	- Pesquise por sub-domínios
    --subdiretorios dominio wordlist   	- Pesquise por sub-diretórios
Exemplo:
    ${SCRIPT} --subdominios exemplo.com seclists/subdominios.txt 
EOF
	exit 0
}

finder() {
    clear;echo -e "${BGre}$(banner)"
    echo -e "Wordlist: ${wordlist} Total de palavras: $(cat ${wordlist} | wc -l)"

    # Use 'while read' para iterar sobre os subdomínios no arquivo
    while read -r sub; do
        sub=$(echo $sub | tr -d '\r')

        if [[ $1 == "1" ]]; then
            url="https://${sub}.${dominio}"
        else
            url="https://${dominio}/${sub}"
        fi

        status=$(curl -H "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0" \
            -m 2 -o /dev/null -s -w "%{http_code}\n" ${url})
        
        # Exiba subdomínios encontrados com status 200 e o número da palavra
        if [[ $status == 200 ]]; then
            echo -e "[Encontrado] $status\t-\t${url}"
        fi
        

        # Verifique se há redirecionamentos (status 301)
        if [[ $status == 301 ]]; then
            urlEficaz=$(curl -H "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0" \
            -Ls -o /dev/null -w "%{url_effective}\n" ${url})
            echo -e "[Encontrado] $status\t-\t${urlEficaz}  ⏎ ${url}"
        fi

    done < "$wordlist" | pv -t

    # Mensagem para indicar o término
    echo -e "Finalizado!"
}

# Verifique se os argumentos do domínio e arquivo de subdomínios foram fornecidos
if [ $# -lt 3 ]; then
    _help
fi

dominio="$2"
wordlist="$3"

while [[ "$1" ]]; do
	case "$1" in
	--subdominios) finder "1" ;;
	--subdiretorios) finder "2";;
	*) echo -e "Opção inválida\n" && _help ;;
	esac
	shift
done
