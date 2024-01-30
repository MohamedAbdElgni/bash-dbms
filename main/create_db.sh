#!/bin/bash
shopt -s extglob
usrcurrentdir=$1
trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM
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
            if [ -d "../.db/$db_name" ]; then  
                echo "This DB name already exists ❌"
                continue
            else
                db_name=$(echo "$db_name" | sed 's/ /-/g')  
                mkdir "../.db/$db_name"
                clear
                echo "DataBase $db_name created successfully." "👍"
                . ./run.sh $usrcurrentdir
                break
                
            fi ;;
        *) 
            echo "Invalid input, write a valid name ❌"
            echo "==========================="
            continue ;;
    esac
done

return 0


