#!/bin/bash
shopt -s extglob

usrcurrentdir=$2
currdb=$1

trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM

clear

function get_tname(){
    # dis t names
    emptyflag=false
    tables_arr=()
    
    for table in *; do

        if [ -d "${table}" ]; then
            
            
            echo "📄 ${table}"
            echo ""
            tables_arr+=($table)
            return 0
        else 
            echo "No tables found"
            emptyflag=true
            break
        fi

    done

}

table_name=""

function get_table_name(){
    clear
    echo "--${currdb} database available tables--"
    get_tname
    get_table_meta
    if [ "$emptyflag" = true ]; then
        clear
        echo "No tables found"
        cd ../../main
        . c_db_menu.sh $currdb $usrcurrentdir
        return 0

    fi
    echo "Enter table to update its data"
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
    for col in ${col_names[@]}; do
        echo "📄 ${col}"
    done
    while true
    do
        read -p "Enter column name to update it: " s_col_name
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

# selected column original value
s_o_col_val=""

function select_col_val(){
    while true
    do
        read -p "Enter original value of the column: " s_o_col_val
        if [[ " ${old_data[@]} " =~ " ${s_o_col_val} " ]]; then
            s_o_col_val=$s_o_col_val
            return 0
        else
            echo "Value not found"
        fi
    done
}

# selected column new value
s_n_col_val=""

function get_update_col_val(){
    while true
    do
        read -p "enter new value for col ${s_col_name}: " s_n_col_val
        case ${dts[$co_indx]} in
            "int" )
                if [[ $s_n_col_val = +([0-9]) ]]; then
                    s_n_col_val=$s_n_col_val
                    return 0
                else
                    echo "Invalid input"
                fi
                ;;
            "str" )
                if [[ $s_n_col_val = +([a-zA-Z]) ]]; then
                    s_n_col_val=$s_n_col_val
                    return 0
                else
                    echo "Invalid input"
                fi
                ;;
            * )
                echo "Invalid input"
                ;;
        esac
    done
}


function update_data(){
    clear
    echo "Updating ${s_col_name} column of table ${table_name} from ${currdb} database"
    echo "============================================================================"
    echo "Original value: ${s_o_col_val}"
    echo "New value: ${s_n_col_val}"
    awk -F "|" -v col_idx_awk="$col_idx_awk" -v s_o_col_val="$s_o_col_val" -v s_n_col_val="$s_n_col_val" 'BEGIN {OFS=FS} (NR>1 && $col_idx_awk==s_o_col_val) {$col_idx_awk=s_n_col_val} {print}' "$table_name/data" > "$table_name/data.tmp"
    sed -i "1s/.*/$(head -n 1 "$table_name/meta")/" "$table_name/data.tmp"
    if [[ $(diff "$table_name/data" "$table_name/data.tmp" | wc -l) -gt 0 ]]; then
        
        if [[ ${pk_status[$co_indx]} = "1" ]]; then
            if [[ $(awk -F "|" -v col_idx_awk="$col_idx_awk" -v s_n_col_val="$s_n_col_val" 'NR>1 {if($col_idx_awk==s_n_col_val) print $col_idx_awk}' "$table_name/data.tmp" | wc -l) -gt 1 ]]; then
                clear
                echo "Col ${s_col_name} is a Primary key and must be unique"
                rm -f "$table_name/data.tmp" 2> /dev/null
                cd ../../main
                . c_db_menu.sh $currdb $usrcurrentdir
                return 0
            fi

        fi
        clear
        mv -f "$table_name/data.tmp" "$table_name/data"
        echo "Updated successfully"
    else
        clear
        mv -f "$table_name/data.tmp" "$table_name/data"
        echo "No matching rows found"
        cd ../../main
        . c_db_menu.sh $currdb $usrcurrentdir
        return 0
    fi
    cd ../../main
    . c_db_menu.sh $currdb $usrcurrentdir
    return 0
}

function update_table(){
    get_table_name
    clear
    
    
    

    if [[ ${#old_data[@]} -gt 1 ]]; then
    echo "old data: ${old_data[@]}"
        select_col
        select_col_val
        get_update_col_val
        update_data
        return 0
    fi

}

update_table
return 0