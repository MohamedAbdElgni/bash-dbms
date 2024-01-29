#!/bin/bash

PS3=$'\e[33mPlease enter your choice: \e[0m'

usrcurrentdir=$1
if [ ! -d "../.db" ]; then
    mkdir ../.db
fi



function main(){

echo "============================================"
echo "=                 Main Menu                ="
echo "============================================"




select choice in "Create-DataBase" "List-DataBase" "Connect-DataBase" "Drop-DataBase" "Exit" "Delete all DateBases"

do

    case $choice in
        # create database block #
        "Create-DataBase" )
            
            . create_db.sh 
        
            return 0

        ;;
        # list database block #
        "List-DataBase" )
            clear
            . list_dbs.sh $usrcurrentdir
            
            return 0
            
        ;;
        # connect database block #
        "Connect-DataBase" )
            
            . con_db.sh $usrcurrentdir
            return 0
        ;;
        # drop database block #
        "Drop-DataBase" )
            . drop_db.sh $usrcurrentdir
            return 0
        ;;
        # exit block
        "Exit" )
            echo "Exiting script from main menu."
            
            cd "$usrcurrentdir"
            
            return 0
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
