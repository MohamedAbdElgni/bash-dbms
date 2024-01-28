#!/bin/bash

# connect to database

. ./list_dbs.sh

function init_con_db(){
    counter=0
    while true; do
    read -p "Enter the name of the database you want to connect to: " db_name
    if [ -d "../.db/$db_name" ]; then
        cd ../.db/$db_name
        echo "You are now connected to $db_name"
        break
    else
        echo "Database not found."
        counter=$((counter+1))
        if [ $counter -eq 3 ]; then
            echo "You have exceeded the number of tries."
            exit 0
        fi
    fi
    done

    
}

init_con_db






