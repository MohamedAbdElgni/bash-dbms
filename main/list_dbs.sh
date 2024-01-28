#!/bin/bash

function list_dbs(){
    # list all databases
    clear
    echo "=====All Databases====="

    for db in ../.db/* ; do
    if [ -d "$db" ]; then
        echo ""
            echo $'\360\237\222\276' "${db##*/}" 
        echo ""

    else
        echo "No Databases found on this device." $'\360\237\222\277'
    fi

    done
    
}

list_dbs