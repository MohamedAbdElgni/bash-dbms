#!/bin/bash
shopt -s extglob
usrcurrentdir = $1
trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM
function drop_db() {

    
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
    emptyflag=false
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
            echo "No databases fddound" $'\360\237\222\277'
            
            emptyflag=true
            
            return 0
            
        fi
    done

    
}
# List all databases
clear
list_dbs
if [ "$emptyflag" = true ]; then
    . run.sh $usrcurrentdir
    return 0
    else
        drop_db

fi






return 0
