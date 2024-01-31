#!/bin/bash
shopt -s extglob

##### important notes #####
##### all the scripts related with the secound menu will start with c_db_  #####
##### c_ for connect ##### <----------=-=-=-
##### this script will be called from con_db.sh ##### <----------=-=-=-=
##### and the tables scripts will start with tb_  #####




usrcurrentdir=$2
currdb=$1

trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM

if [[ $PWD == *"main" ]]; then
    cd ../.db/$currdb
fi

#echo $locdb

function c_db_menu(){



echo "============================================"
echo "=        $currdb database connected        ="
echo "============================================"

PS3=$'\e[33mPlease enter your choice: \e[0m'
select choice in "Create-Table" "List-Tables" "Drop-Table" "Insert-Into-Table" "Select-From-Table" "Delete-From-Table" "Update-Table" "Back-to-Main-menu"

do
    case $choice in
        "Create-Table" )
            
            . ../../main/tb_create.sh $currdb $usrcurrentdir
            break

        ;;
        "List-Tables" )
            
            . ../../main/tb_list.sh $currdb $usrcurrentdir
            break
        ;;
        "Drop-Table" )
            
            . ../../main/tb_drop.sh $currdb $usrcurrentdir
            break
        ;;
        "Insert-Into-Table" )

            . ../../main/tb_insert.sh $currdb $usrcurrentdir
            break
        ;;
        "Select-From-Table" )
            
            . ../../main/tb_select.sh $currdb $usrcurrentdir
            break
        ;;
        "Delete-From-Table" )
            . ../../main/tb_f_delete.sh $currdb $usrcurrentdir
            break
        ;;
        "Update-Table" )
            echo "Update-Table selected"
            # call for update table script to be implemented
        ;;
        "Back-to-Main-menu" )
            echo "Back-to-Main menu "
            clear
            cd ../../main
            . run.sh $usrcurrentdir
            break
        ;;
        
        * )
            echo "Invalid option $REPLY"
        ;;
    esac
done
}

c_db_menu

return 0


