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
            tables_arr+=($table)
        else 
            echo "No tables found"
            emptyflag=true
            break
        fi

    done

}

table_name=""

function get_table_name(){
    for table in *; do

        if [ -d "${table}" ]; then
            echo "📄 ${table}"
            echo ""
        fi
    done

    echo "--${currdb} database available tables--"
    echo "=========================="
    while true
    do
        ##echo "${tables_arr[@]}"
        read -p "Enter table name: " table_name
        for table in "${tables_arr[@]}"; do
            if [ $table = $table_name ]; then
                return 0
               break
            fi
        done
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
        clear
        echo "clo ${s_col_name} selected of table ${table_name} from ${currdb} database"
        echo "============================================================================"
    while true
    do
        read -p "Enter value for ${s_col_name} with data type ${dts[co_indx]}: " s_d_col_value
        case ${dts[co_indx]} in
            "int" )
                if [[ $s_col_value =~ ^[0-9]*$ ]]; then
                    awk -F "|" -v col_idx_awk="$col_idx_awk" -v s_d_col_value="$s_d_col_value" 'NR==1 || (NR>1 && $col_idx_awk!=s_d_col_value)' "$table_name/data" > "$table_name/data.tmp"
                    if [[ $(diff "$table_name/data" "$table_name/data.tmp" | wc -l) -gt 0 ]]; then
                        clear
                        mv -f "$table_name/data.tmp" "$table_name/data"
                        echo "Row deleted successfully"
                    else
                        clear
                        mv -f "$table_name/data.tmp" "$table_name/data"
                        echo "No matching rows found"
                    fi

                    cd ../../main
                    . c_db_menu.sh $currdb $usrcurrentdir
                    return 0
                else
                    echo "Invalid data type"
                fi
                ;;
            "str" )
                if [[ $s_d_col_value =~ ^[a-zA-Z]+$ ]]; then
                    awk -F "|" -v col_idx_awk="$col_idx_awk" -v s_d_col_value="$s_d_col_value" 'NR==1 || (NR>1 && $col_idx_awk!=s_d_col_value)' "$table_name/data" > "$table_name/data.tmp"

                    
                    if [[ $(diff "$table_name/data" "$table_name/data.tmp" | wc -l) -gt 0 ]]; then
                        clear
                        mv -f "$table_name/data.tmp" "$table_name/data"
                        echo "Row deleted successfully"
                    else
                        clear
                        mv -f "$table_name/data.tmp" "$table_name/data"
                        echo "No matching rows found"
                    fi

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
    clear
    echo "${table_name} table selected from ${currdb} database"
    get_table_meta
    select_col
    delete_value
    return 0
}
if [ "$emptyflag" = true ]; then
    echo "No tables found"
    echo "Please create a table first."
    . ../../main/c_db_menu.sh $currdb $usrcurrentdir
    return 0
else
get_tname
delete_from_table
fi

return 0










