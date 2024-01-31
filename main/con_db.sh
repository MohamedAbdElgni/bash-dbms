#!/bin/bash
shopt -s extglob
# connect to database
usrcurrentdir=$1
trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM
clear

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
            echo "No databases found" $'\360\237\222\277'
            emptyflag=true
            
                return 0
            
        fi
    done

    
}

list_dbs

function init_db_con(){

    if [ ! -d "../.db" ]; then
        
        . run.sh $usrcurrentdir
        return 0
    fi
    
    while true
    do
    read -p "Enter DataBase Name to connect it: " con_db_name

        # validation to be added<-----------------
        
        case $con_db_name in
            [A-Za-z_]*[A-Za-z0-9_]* )
                
                #con_db_name=$(echo "$con_db_name" | sed 's/ /-/g')
                
                if [ -d "../.db/$con_db_name" ]; then
                    clear
                    
                    . c_db_menu.sh $con_db_name $usrcurrentdir
                    return 0
                    
                else
                    echo "DataBase--> $con_db_name does not exist." "❌"
                    echo "Please try different name."
                fi
            ;;
            * )
                echo "Invalid DataBase Name."
            
            ;;
        esac
    done

}

clear
list_dbs
if [ "$emptyflag" = true ]; then
    . run.sh $usrcurrentdir
    return 0
else
    init_db_con
fi

return 0














