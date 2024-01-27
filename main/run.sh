#!/bin/bash

PS3=$'\e[33mPlease enter your choice: \e[0m'

chmod +x *.sh
# db emoji
# 
# echo $'\360\237\222\276'
#
# inti a .db directory if not.
# enable deleting .db directory



if [ ! -d "../.db" ]; then
    mkdir ../.db
fi
echo "============================================"
echo "=                 Main Menu                ="
echo "============================================"



# make option in new colors 
select choice in "Create-DataBase" "List-DataBase" "Connect-DataBase" "Drop-DataBase" "Exit" "reset DateBase"

do

    case $choice in
        # create database block #
        "Create-DataBase" )
            ./create_db.sh
        ;;
        # list database block #
        "List-DataBase" )
            echo "=====All Databases====="
            
            for db in ../.db/*; do
            echo ""
                echo $'\360\237\222\276' "${db##*/}" 
            echo ""
            done
            echo "======================="
            while true
            read -p "Back to main menu (y-n):-" response
            do
                case $response in
                    [yY] | [yY][eE][sS] )
                        ./run.sh
                        break
                    ;;
                    [nN] | [nN][oO] )
                        echo "Exiting script."
                        break
                    ;;
                    *)
                        echo "Invalid input..."
                    ;;
                esac
            done
            
        ;;
        # connect database block #
        "Connect-DataBase" )
            echo "3 selected"
        ;;
        # drop database block #
        "Drop-DataBase" )
            echo "4 selected"
        ;;
        # exit block
        "Exit" )
            echo "Exiting script."
            break
        ;;
        # reset database block #
        "reset .db" )
            echo "Resetting .db"
            db_directory="../.db"
            
            if [ -d "$db_directory" ]; then
                find "$db_directory" -mindepth 1 -delete
                echo "Database reset successfully."
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
