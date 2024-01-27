#!/bin/bash

while true
do
    read -p "Enter DataBase Name: " db_name
    
    # validations
    # no numbers or spaces at the beginning or end 
    # if spaces in the middle replace with -
    # to be enhanced more later

    if [[ $db_name =~ ^[a-zA-Z_]+[a-zA-Z0-9_[:space:]-]*[a-zA-Z0-9_]+$ ]]; then
        # replace spaces with hyphens
        db_name=$(echo "$db_name" | sed 's/ /-/g')
        
        # check if db_name exists
        if [ ! -d "../.db/$db_name" ]; then
            mkdir "../.db/$db_name"
            echo "DataBase $db_name created successfully."
            # return to main menu
            ./run.sh
            break
        else
            echo "DataBase $db_name already exists."
            echo "Please try different name."
        fi
    else
        echo "Invalid DataBase Name."
    fi
done