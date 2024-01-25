#!/bin/bash






select choice in "Create-DataBase" "List-DataBase" "Connect-DataBase" "Drop-DataBase"
do
case $choice in
        "Create-DataBase" )
            ./createdb.sh
        ;;
        "List-DataBase" )
            echo "2 selected"
        ;;
        "Connect-DataBase" )
            echo "3 selected"
        ;;
        "Drop-DataBase" )
            echo "4 selected"
        ;;
    esac
done
