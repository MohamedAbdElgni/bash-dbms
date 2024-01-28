#!/bin/bash

function drop_db() {

    # List all databases
    clear
    . list_dbs.sh

    while true
    do
        read -p "Enter DataBase Name To Be Deleted: " dd_name

        case $dd_name in
            "") 
                echo "Sorry, the name can't be empty"
                echo "==========================="
                continue ;;
            *[[:space:]] | *[[:space:]]* | [[:space:]]*) 
                echo "Sorry, the name can't have spaces"
                echo "==========================="
                continue ;;
            [0-9]*) 
                echo "Sorry, the name can't start with integers"
                echo "==========================="
                continue ;;
            *[a-zA-Z_]*[a-zA-Z_] | [a-zA-Z_]) 
                if [ -d "../.db/$dd_name" ]; then
                    rm -r "../.db/$dd_name"
                    clear
                    echo "DataBase $dd_name deleted successfully." "👍"
                    ./run.sh
                    exit 0
                else
                    echo "DataBase--> $dd_name does not exist." "❌"
                    echo "Please try different name."
                    continue
                fi ;;
            *) 
                echo "Invalid input, write a valid name"
                echo "==========================="
                continue ;;
        esac
    done
}

drop_db
