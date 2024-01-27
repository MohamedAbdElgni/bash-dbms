#!/bin/bash

cd ../DATA_META

while true; do
    # Reading the input from the user
    echo "Enter the name of the DB you want to create"
    read db_name

    # Validating the input
    case $db_name in
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
        if (find $db_name `ls -F | grep /` &> ~/../../dev/null)
        then
        echo "oh my god, Looks like the DB already exists"
            continue
            else
            mkdir "$db_name"
            break 
            fi;;
        *) 
            echo "Invalid input, write a valid name"
            echo "==========================="
            continue ;;
    esac
done

cd - > /dev/null 2>&1
