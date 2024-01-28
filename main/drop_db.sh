#!/bin/bash

function drop_db(){

    # list all databases
    
    clear
    . list_dbs.sh

    # to be added validation later
    while true
    do
    read -p "Enter DataBase Name To Be Deleted: " dd_name
        if [ -d "../.db/$dd_name" ]; then
            rm -r "../.db/$dd_name"
            clear
            echo "DataBase $dd_name deleted successfully." "👍"
            ./run.sh
            exit 0
            break
        else
            echo "DataBase--> $dd_name does not exist." "❌"
            echo "Please try different name."
        fi
    done

}

drop_db