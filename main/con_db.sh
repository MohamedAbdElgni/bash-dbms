#!/bin/bash

# connect to database

clear

dbs=( $(ls -F ../.db | grep "/" | tr / " ") )

    # Check if the array is empty
    if [ ${#dbs[@]} -eq 0 ]; then
        echo "No Databases found on this device." $'\360\237\222\277'
        read -p "Do you want to create a new DataBase? (y/n) " choice
        if [ "$choice" = "y" ]; then
            ./create_db.sh
            exit 0
        else
            clear
            ./run.sh
            exit 0
        fi
    fi

    
    for db in "${dbs[@]}" ; do
        echo ""
        echo $'\360\237\222\276' "${db}" 
        echo ""
    done

function init_db_con(){
    
    while true
    do
    read -p "Enter DataBase Name: " con_db_name

        # validation to be added<-----------------
        
        case $con_db_name in
            [A-Za-z_]*[A-Za-z0-9_]* )
                
                #con_db_name=$(echo "$con_db_name" | sed 's/ /-/g')
                
                if [ -d "../.db/$con_db_name" ]; then
                    clear
                    
                    . c_db_menu.sh $con_db_name
                    exit 0
                    
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

init_db_con














