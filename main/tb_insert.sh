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
    while true
        echo "--Enter table nAme to insert into--"
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




function get_data_for_table(){
    col_names=($(awk -F "|" 'NR==1 {for(i=1;i<=NF;i++) print $i}' "$table_name/meta"))
    dts=($(awk -F "|" 'NR==2 {for(i=1;i<=NF;i++) print $i}' "$table_name/meta"))
    pk_status=($(awk -F "|" 'NR==3 {for(i=1;i<=NF;i++) print $i}' "$table_name/meta"))
    old_data=($(awk -F "|" 'NR>1 {for(i=1;i<=NF;i++) print $i}' "$table_name/data"))
    clear
    echo "Enter data for table ${table_name}"
    echo "=================================="
    for (( i = 0; i < ${#col_names[@]}; i++ )); do
        # get the column name
        col_name=${col_names[$i]}
        # get the data type
        dt=${dts[$i]}
        while true
        read -p "Enter ${col_name} (${dt}): " col_value
        do
            if [[ $dt == "int" ]]; then
                if [[ $col_value =~ ^[0-9]+$ ]]; then
                    new_data+=($col_value)
                    break
                else
                    echo "Invalid data type"
                fi
            elif [[ $dt == "str" ]]; then
                if [[ $col_value =~ ^[a-zA-Z]+$ ]]; then
                    new_data+=($col_value)
                    break
                else
                    echo "Invalid data type"
                fi
            fi
        done
    done
}

function check_pk(){
pk_col=0
for (( i = 0; i < ${#pk_status[@]}; i++ )); do
    if [[ ${pk_status[$i]} == 1 ]]; then
        pk_col=$i
    fi
done
pk_col_for_awk=$(($pk_col+1))


pk_value=${new_data[$pk_col]}
# the big awk command
pk_exists=$(awk -F "|" -v pk_col="$pk_col_for_awk" -v pk_value="$pk_value" 'NR>1 {if(tolower($pk_col) == tolower(pk_value)) {print "true"; exit}}' "$table_name/data")


pk_col_dt=${dts[$pk_col]}



if [[ $pk_exists == "true" ]]; then
    echo "col ${col_names[$pk_col]} with value ${pk_value} already exists"
    echo "==========================="
    echo "press any key to back to the db menu"
    read -n 1
    clear
    cd ../../main
    . c_db_menu.sh $currdb $usrcurrentdir
    return 0

    
else
    echo "${new_data[*]}" | tr ' ' '|' >> "$table_name/data"
    clear
    echo "Record inserted successfully." "👍"
    cd ../../main
    . c_db_menu.sh $currdb $usrcurrentdir
    return 0
fi

}

get_tname

if [[ ${#tables_arr[@]} -gt 0 ]]; then
    get_table_name
    get_data_for_table
    check_pk
else
    
    cd ../../main
    . c_db_menu.sh $currdb $usrcurrentdir
    return 0
fi

return 0



