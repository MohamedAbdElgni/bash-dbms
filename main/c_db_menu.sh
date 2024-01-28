#!/bin/bash
##### important notes #####
##### all the scripts related with the secound menu will start with c_db_ prefix #####
##### c_ for connect ##### <----------=-=-=-
##### this script will be called from con_db.sh ##### <----------=-=-=-=
##### and the tables scripts will start with tb_ prefix #####
##this var for the selected db name will be passed to c_db_menu.sh as a first argument##

currdb=$1
locdb="../.db/$currdb"
echo "============================================"
echo "=        $currdb database connected        ="
echo "============================================"

PS3=$'\e[33mPlease enter your choice: \e[0m'




#echo $locdb

function c_db_menu(){
select choice in "Create-Table" "List-Tables" "Drop-Table" "Insert-Into-Table" "Select-From-Table" "Delete-From-Table" "Update-Table" "Back-to-Main-menu" "Exit"

do
    case $choice in
        "Create-Table" )
            echo "Create-Table selected"
            # call for create table script to be implemented
        ;;
        "List-Tables" )
            echo "List-Tables selected"
            # call for list tables script to be implemented
        ;;
        "Drop-Table" )
            echo "Drop-Table selected"
            # call for drop table script to be implemented
        ;;
        "Insert-Into-Table" )
            echo "Insert-Into-Table selected"
            # call for insert into table script to be implemented
        ;;
        "Select-From-Table" )
            echo "Select-From-Table selected"
            # call for select from table script to be implemented
        ;;
        "Delete-From-Table" )
            echo "Delete-From-Table selected"
            # call for delete from table script to be implemented
        ;;
        "Update-Table" )
            echo "Update-Table selected"
            # call for update table script to be implemented
        ;;
        "Back-to-Main-menu" )
            echo "Back-to-Main menu "
            clear
            ./run.sh
            exit 0
        ;;
        "Exit" )
            echo "Exiting script."
            exit 0
        ;;
        * )
            echo "Invalid option $REPLY"
        ;;
    esac
done
}

c_db_menu

