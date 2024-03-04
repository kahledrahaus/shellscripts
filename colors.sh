#!/bin/bash

function action() {
    prompt="$1"
    echo -e -n "\033[1;32m$prompt"
    echo -e -n '\033[0m'
    read
}

function alert() {
    prompt="$1"
    echo -e -n "\033[1;33m$prompt"
    echo -e -n '\033[0m'
    read
}

function danger() {
    prompt="$1"
    echo -e -n "\033[1;31m$prompt"
    echo -e -n '\033[0m'
    read
}

action "\nPressione enter para continuar..."
# Textos normais
echo -e '\033[01;32mMENSAGEM\033[00;37m'
echo -e '\033[02;32mMENSAGEM\033[00;37m'
echo -e '\033[06;32mMENSAGEM\033[00;37m'
echo -e '\033[07;32mMENSAGEM\033[00;37m'
echo -e '\033[09;32mMENSAGEM\033[00;37m'

alert "\nPressione enter para continuar..."
# Alertas
echo -e '\033[01;33mALERTA\033[00;37m'
echo -e '\033[02;33mALERTA\033[00;37m'
echo -e '\033[06;33mALERTA\033[00;37m'
echo -e '\033[07;33mALERTA\033[00;37m'
echo -e '\033[09;33mALERTA\033[00;37m'

danger "\nPressione enter para continuar..."
# Erros
echo -e '\033[01;31mERRO FATAL\033[00;37m'
echo -e '\033[02;31mERRO FATAL\033[00;37m'
echo -e '\033[06;31mERRO FATAL\033[00;37m'
echo -e '\033[07;31mERRO FATAL\033[00;37m'
echo -e '\033[09;31mERRO FATAL\033[00;37m'
