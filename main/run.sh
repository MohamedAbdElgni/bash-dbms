#!/bin/bash

PS3=$'\e[33mPlease enter your choice: \e[0m'
# add date and time to the log file

chmod +x *.sh 2> ./error.log
chmod +x ../.db/*.sh 2> ./error.log
chmod +x main/*.sh 2> ./error.log



if [ ! -d "../.db" ]; then
    mkdir ../.db
fi


# db emoji
# 
# echo $'\360\237\222\276'
#
# inti a .db directory if not.
# enable deleting .db directory


function main(){

echo "============================================"
echo "=                 Main Menu                ="
echo "============================================"




select choice in "Create-DataBase" "List-DataBase" "Connect-DataBase" "Drop-DataBase" "Exit" "Delete all DateBases"

do

    case $choice in
        # create database block #
        "Create-DataBase" )
            
            ./create_db.sh 
        
            exit 0

        ;;
        # list database block #
        "List-DataBase" )
            clear
            ./list_dbs.sh
            main
            
        ;;
        # connect database block #
        "Connect-DataBase" )
            echo "3 selected"
        ;;
        # drop database block #
        "Drop-DataBase" )
            ./drop_db.sh
            exit 0
        ;;
        # exit block
        "Exit" )
            echo "Exiting script."
            exit 0
        ;;
        # reset database block #
        "Delete all DateBases" )
            clear
            echo "Resetting .db"
            db_directory="../.db"
            
            if [ -d "$db_directory" ]; then
                find "$db_directory" -mindepth 1 -delete
                echo "Database reset successfully."
                
                main 
                    
            else
                echo "Error: Database directory does not exist."
            fi
            ;;
        # default block #
        * )
        echo "wrong option"
        ;;
        
    esac

done

}

main
