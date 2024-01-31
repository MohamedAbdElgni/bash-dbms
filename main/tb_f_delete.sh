#!/bin/bash
shopt -s extglob

usrcurrentdir=$2
currdb=$1

trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM



clear

function get_tname(){
    
    tables_arr=()

    for table in *; do

        if [ -d "${table}" ]; then
            clear
            
            echo "📄 ${table}"
            echo ""
            tables_arr+=($table)
            return 0
        else 
            echo "No tables found"
            break
        fi

    done

}

table_name=""

function get_table_name(){
    get_tname
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

col_names=()

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
        read -p "Enter column name to delete based on: " s_col_name
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




s_d_col_value=""
function delete_value(){

    while true
    do
        read -p "Enter value for ${s_col_name} with data type ${dts[co_indx]}: " s_d_col_value
        case ${dts[co_indx]} in
            "int" )
                if [[ $s_col_value =~ ^[0-9]*$ ]]; then
                    
                    awk -F "|" -v col_idx_awk="$col_idx_awk" -v s_d_col_value="$s_d_col_value" 'NR==1 || (NR>1 && $col_idx_awk!=s_d_col_value)' "$table_name/data" > "$table_name/data.tmp" && mv -f "$table_name/data.tmp" "$table_name/data"
                    clear
                    echo "row deleted successfully"
                    cd ../../main
                    . c_db_menu.sh $currdb $usrcurrentdir
                    return 0
                    
                else
                    echo "Invalid data type"
                fi
            ;;
            "str" )
                if [[ $s_d_col_value =~ ^[a-zA-Z]+$ ]]; then
                    awk -F "|" -v col_idx_awk="$col_idx_awk" -v s_d_col_value="$s_d_col_value" 'NR==1 || (NR>1 && $col_idx_awk!=s_d_col_value)' "$table_name/data" > "$table_name/data.tmp" && mv -f "$table_name/data.tmp" "$table_name/data"
                    clear
                    echo "row deleted successfully"
                    cd ../../main
                    
                    . c_db_menu.sh $currdb $usrcurrentdir
                    return 0
                    
                else
                    echo "Invalid data type"
                fi
            ;;
        esac
    done

}

function delete_from_table(){
    get_table_name
    get_table_meta
    select_col
    delete_value
    return 0
}

delete_from_table

return 0










