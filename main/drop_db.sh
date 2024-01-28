#!/bin/bash

function drop_db(){
    # list all databases
    # ask user to choose one from the selected list
    
    # list all databases
    clear
    . list_dbs.sh


    while true
    do
    read -p "Enter DataBase Name: " dd_name
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