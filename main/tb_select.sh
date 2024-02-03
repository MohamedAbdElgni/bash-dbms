#!/bin/bash
shopt -s extglob
currdb=$1
usrcurrentdir=$2
done_flag=0
pk_flag=true
new_data=()
trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM
clear

function get_tname(){
    # count and get t names
    emptyflag=false
    tables_arr=()
    
    for table in *; do

        if [ -d "${table}" ]; then

            tables_arr+=($table)
            
        else 
            
            emptyflag=true
            return 0
        fi

    done

}

table_name=""

function get_table_name(){
    
    
    
    echo "Enter table to select from"
    echo "=========================="
    while true
    do
        read -p "Enter table name: " table_name
        if [[ " ${tables_arr[@]} " =~ " ${table_name} " ]]; then
            return 0
        else
            echo "Table not found"
        fi
    done
}



function get_table_meta(){
    col_names=($(awk -F "|" 'NR==1 {for(i=1;i<=NF;i++) print $i}' "$table_name/meta"))
    dts=($(awk -F "|" 'NR==2 {for(i=1;i<=NF;i++) print $i}' "$table_name/meta"))
    pk_status=($(awk -F "|" 'NR==3 {for(i=1;i<=NF;i++) print $i}' "$table_name/meta"))
    old_data=($(awk -F "|" 'NR>1 {for(i=1;i<=NF;i++) print $i}' "$table_name/data"))
}


# selected column name
s_col_name=""

function select_col(){
    echo "Select column to Display"
    for col in ${col_names[@]}; do
        echo "📄 ${col}"
    done
    while true
    do
        read -p "Enter column name to select from: " s_col_name
        if [[ " ${col_names[@]} " =~ " ${s_col_name} " ]]; then
            s_col_name=$s_col_name
            co_indx=$(echo ${col_names[@]/$s_col_name//} | cut -d/ -f1 | wc -w)
            col_idx_awk=$(($co_indx+1))
            return 0
        else
            echo "Column not found"
        fi
    done
}

function select_menu(){
    echo "==select from ${table_name} table from ${currdb} database=="
    select choice in "Select-All" "Select-Column" "Select-Column-Where" "Back-to-${currdb}DB-menu"
    do
        case $choice in
            "Select-All" )
                clear
                select_all
                break
                
            ;;
            "Select-Column" )
                clear
                select_by_col
                break
            ;;
            "Select-Column-Where" )
                clear
                select_where_eq
                break
            ;;
            "Back-to-${currdb}DB-menu" )
                echo "Back-to-Table-menu selected"
                cd ../../main
                clear
                . c_db_menu.sh $currdb $usrcurrentdir
                break
            ;;
            * )
                echo "Invalid option"
            ;;
        esac
    done
}

function select_all(){
    clear
    echo "All columns selected of table ${table_name} from ${currdb} database"
    echo "============================================================================"
    
    awk -F "|" 'NR==1 {for(i=1;i<=NF;i++) printf "%-15s",$i; print ""; next} {for(i=1;i<=NF;i++) printf "%-15s",$i; print ""}' "$table_name/data"
    #press any key to back to select menu
    read -n 1 -s -r -p "Press any key to back to select menu"
    clear
    select_menu
    return 0
}

function select_by_col(){

    select_col
    clear
    echo "col ${s_col_name} selected of table ${table_name} from ${currdb} database"
    echo "============================================================================"
    awk -F "|" -v col_idx_awk="$col_idx_awk" 'NR==1 {print $col_idx_awk} NR>1 {print $col_idx_awk}' "$table_name/data"
    
    read -n 1 -s -r -p "Press any key to back to select menu"
    clear
    select_menu
    return 0
}

function select_where_eq(){
    select_col
    
    clear
    echo "col ${s_col_name} selected of table ${table_name} from ${currdb} database"
    echo "============================================================================"
    while true
    do
        read -p "Enter value for ${s_col_name} with data type ${dts[co_indx]}: " s_col_value
        case ${dts[co_indx]} in
            "int" )
                if [[ $s_col_value =~ ^[0-9]*$ ]]; then
                    
                    awk -F "|" -v col_idx_awk="$col_idx_awk" -v s_col_value="$s_col_value" '
                        NR==1 || (NR>1 && $col_idx_awk==s_col_value) {
                            for(i=1; i<=NF; i++) printf "%-10s", $i;
                            print "";
                        }' "$table_name/data"

                        read -n 1 -s -r -p "Press any key to back to select menu"
                        clear
                        select_menu
                        return 0
                else
                    echo "Invalid data type"
                fi
                ;;
            "str" )
                if [[ $s_col_value =~ ^[a-zA-Z]+$ ]]; then
                    
                    awk -F "|" -v col_idx_awk="$col_idx_awk" -v s_col_value="$s_col_value" '
                        NR==1 || (NR>1 && $col_idx_awk==s_col_value) {
                            for(i=1; i<=NF; i++) printf "%-20s", $i;
                            print "";
                        }' "$table_name/data"

                        read -n 1 -s -r -p "Press any key to back to select menu"
                        clear
                        select_menu
                        return 0
                    
                else
                    echo "Invalid data type"
                fi
                ;;
        esac
    done
}





# test
get_tname
if [ "$emptyflag" = true ]; then
    echo "No tables found"
    echo "Please create a table first."
    . ../../main/c_db_menu.sh $currdb $usrcurrentdir
    return 0
else
        # to be refactored
        echo "--${currdb} database available tables--"
        echo ""
        for table in ${tables_arr[@]}; do
            echo "📄 ${table}"
            echo ""
        done
    get_table_name
    clear
    get_table_meta
    select_menu
fi
return 0


