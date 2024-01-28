#!/bin/bash

while true
do
    read -p "Enter DataBase Name: " db_name

    case $db_name in
        "") 
            echo "Sorry, the name can't be empty ❌"
            echo "==========================="
            continue ;;
        *[[:space:]] | *[[:space:]]* | [[:space:]]*) 
            echo "Sorry, the name can't have spaces ❌"
            echo "==========================="
            continue ;;
        [0-9]*) 
            echo "Sorry, the name can't start with integers ❌"
            echo "==========================="
            continue ;;
        *[a-zA-Z_]*[a-zA-Z_] | [a-zA-Z_]) 
            if [ -d "../.db/$db_name" ]; then  # Check for existing directory
                echo "oh my god, Looks like the DB already exists ❌"
                continue
            else
                db_name=$(echo "$db_name" | sed 's/ /-/g')  # Replace spaces with hyphens
                mkdir "../.db/$db_name"
                echo "DataBase $db_name created successfully." "👍"
                ./run.sh
                exit 0
            fi ;;
        *) 
            echo "Invalid input, write a valid name ❌"
            echo "==========================="
            continue ;;
    esac
done


