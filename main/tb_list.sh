#!/bin/bash
shopt -s extglob
usrcurrentdir=$2
trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM
db_name=$1
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

. ../../main/c_db_menu.sh $db_name $usrcurrentdir

return 0
