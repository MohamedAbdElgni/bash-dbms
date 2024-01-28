#!/bin/bash

function list_dbs(){
    clear
    echo "=====All Databases====="

    for db in ../.db/* ; do
    if [ -d "$db" ]; then
        echo ""
            echo $'\360\237\222\276' "${db##*/}" 
        echo ""

    else
        echo "No Databases found on this device." $'\360\237\222\277'
        read -p "Do you want to create a new DataBase? (y/n) " choice
        if [ $choice == "y" ]; then
            ./create_db.sh
            exit 0
        else
            clear
            ./run.sh
            exit 0
        fi
    fi

    done
    
}

list_dbs