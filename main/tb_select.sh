#!/bin/bash
shopt -s extglob
currdb=$1
usrcurrentdir=$2
done_flag=0
pk_flag=true
new_data=()
trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM
clear

function get_table_name(){
    clear
    echo "select table to insert into"
    while true
    do
        read -p "Enter table name: " table_name
        if [[ " ${tables_arr[@]} " =~ " ${table_name} " ]]; then
            break
        else
            echo "Table not found"
        fi
    done
}

function get_tname(){
    
    tables_arr=()

    for table in *; do

        if [ -d "${table}" ]; then
            clear
            
            echo "📄 ${table}"
            echo ""
            tables_arr+=($table)
        else 
            echo "No tables found"
            break
        fi

    done

}