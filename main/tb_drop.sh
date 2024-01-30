#!/bin/bash
shopt -s extglob
db_name=$1
usrcurrentdir=$2
trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM
echo "===============$db_name DataBase==============="
clear
 for table in *; do
        if [ -d "${table}" ]; then
            
            echo "📄 ${table}"
            echo ""
        else 
            echo "No tables found"
            break
        fi

    done
function drop_table() {
    while true
    do
        read -p "Enter Table Name to drop it: " tb_name

        case $tb_name in
            [A-Za-z_]*[A-Za-z0-9_]* )
                
                if [ -d "$tb_name" ]; then
                read -p "Are you sure you want to drop this table? (y/n) " answer
                case $answer in
                    [yY]* )
                        echo "Dropping table $tb_name..."
                        rm -r $tb_name > /dev/null 2>&1
                        clear
                        echo "Table $tb_name dropped successfully." "👍"
                        
                        break
                    ;;
                    [nN]* )
                    echo "Table $tb_name not dropped."
                    break

                    ;;
                    * )
                    echo "Please enter y or n."
                    ;;
                esac

                else
                    echo "Table--> $tb_name does not exist." "❌"
                    echo "Please try different name."
                fi
            ;;
            * )
                echo "Invalid Table Name."
            
            ;;
        esac
    done
}

drop_table
. ../../main/c_db_menu.sh $db_name $usrcurrentdir

return 0