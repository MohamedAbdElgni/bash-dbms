#!/bin/bash

list_dbs() {
    
    dbs=( $(ls -F ../.db | grep "/" | tr / " ") )

    # Check if the array is empty
    if [ ${#dbs[@]} -eq 0 ]; then
        echo "No Databases found on this device." $'\360\237\222\277'
        read -p "Do you want to create a new DataBase? (y/n) " choice
        if [ "$choice" = "y" ]; then
            ./create_db.sh
            exit 0
        else
            clear
            ./run.sh
            exit 0
        fi
    fi

    
    for db in "${dbs[@]}" ; do
        echo ""
        echo $'\360\237\222\276' "${db}" 
        echo ""
    done
}

list_dbs