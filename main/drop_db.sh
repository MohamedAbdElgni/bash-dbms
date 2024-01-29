#!/bin/bash
usrcurrentdir = $1
function drop_db() {

    # List all databases
    clear
    list_dbs

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
                    echo $PWD
                    echo "$dd_name"

                    rm -r "../.db/$dd_name" > /dev/null 2>&1
                    clear
                    echo "DataBase $dd_name deleted successfully." "👍"
                    . run.sh $usrcurrentdir
                    break
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

list_dbs() {
    
    dbs=( $(ls -F ../.db | grep "/" | tr / " ") )

    # Check if the array is empty
    for db in ../.db/*; do
        if [ -d "${db}" ]; then
            # extract the database name from the path with sed or awk
            db_name=$(echo "$db" | sed 's/.*\///')
            echo ""
            echo $'\360\237\222\276' "$db_name"
            echo ""
        else 
            echo "No databases found" $'\360\237\222\277'
            break
        fi
    done

    
}

drop_db



return 0
