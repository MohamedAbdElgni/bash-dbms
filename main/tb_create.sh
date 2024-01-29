#!/bin/bash
usrcurrentdir=$2
db_name=$1

# col names will be stored in an array with its colnames and data types and pk or not
# each table will have 1 pk only
# three lines will be added to the table file
# col_name
# data_type
# pk or not (pk will be 1 and not pk will be 0)
# the file rill be sperated by : between each col
let num_cols=0
let got_pk_flag=0
data_type=""
table_name=""
col_names=()
data_types=()
pk_status=()


# each table wil have 1 pk so we will use pk flag


function get_num_of_cols(){
    # Helper function to get the number of cols from the user
    # and store it in num_cols
    while true

    do
    read -p "Enter number of columns: " num_of_cols

        case $num_of_cols in
            "") 
                echo "Sorry, the number can't be empty ❌"
                echo "==========================="
                continue ;;
            *[[:space:]] | *[[:space:]]* | [[:space:]]*) 
                echo "Sorry, the number can't have spaces ❌"
                echo "==========================="
                continue ;;
            [0-9]*)
                if [ $num_of_cols -le 0 ]; then
                    echo "Sorry, the number can't be less than 1 ❌"
                    echo "==========================="
                    continue
                else
                    # if the number is valid assign it to num_cols
                    num_cols=$num_of_cols
                fi 
                break ;;
            *)
                echo "Invalid input, write a valid number ❌"
                echo "==========================="
                continue ;;
        esac
    done
}

function ask_col_name(){
    # Helper function to get the col name from the user
    # and store it in col_names array
    while true
    do
        read -p "Enter col name: " col_name

        case $col_name in
            "") 
                echo "Sorry, the col name can't be empty ❌"
                echo "==========================="
                continue ;;
            *[[:space:]] | *[[:space:]]* | [[:space:]]*) 
                echo "Sorry, the col name can't have spaces ❌"
                echo "==========================="
                continue ;;
            
            [0-9]*)
                echo "Sorry, the col name can't start with a number ❌"
                echo "==========================="
                continue ;;
            
            *[a-zA-Z_]*[a-zA-Z_] | [a-zA-Z_]) 
            # check if exists in the col_names array
                if [[ " ${col_names[@]} " =~ " ${col_name} " ]]; then
                    echo "Col name already exists ❌"
                    echo "==========================="
                    continue
                else
                    # if the col name is valid append it to col_names array
                    col_names+=($col_name)
                    break
                fi
                
                ;;
        esac
    done


}

function ask_pk(){
    # Helper function to get the pk from the user
    # and store it in pk_status array
    
    if [ $got_pk_flag -eq 0 ]; then
        # ask the user for pk
        while true
        do
            read -p "Is this col a primary key? (y/n): " pk

            case $pk in
                "yes" | "y" | "YES" | "Y" | "Yes")
                    # if the user entered yes then append 1 to pk_status array
                    pk_status+=(1)
                    # set got_pk_flag to 1
                    got_pk_flag=1
                    break ;;
                "no" | "n" | "NO" | "N" | "No")
                    # if the user entered no then append 0 to pk_status array
                    pk_status+=(0)
                    break ;; 
                *)
                    echo "Invalid input, write a valid answer ❌"
                    echo "==========================="
                    continue ;;
                    
            esac
        done
    else
        # if got_pk_flag is 1 then the user already entered a pk
        # so we will append 0 to pk_status array
        pk_status+=(0)
    fi 

}

function ask_data_type(){
    # Helper function get the data type from the user
    #store it in data_types array

    while true
    do
        read -p "Enter data type (int/str): " data_type

        case $data_type in
            "int")
                # if the data type is int then append it to data_types array
                data_types+=($data_type)
                break ;;    
            "str")
                # if the data type is str then append it to data_types array
                data_types+=($data_type)
                break ;;
            *)
                echo "Invalid input, write a valid data type ❌"
                echo "==========================="
                continue ;;
        esac
    done


}








function create_table(){
    # this function responsible for creating the table and creats dir for the table with table name
    # and creates the table data and the meta file
    # this uses the helper functions above
    clear
    echo "=================Create Table in $db_name-DataBase================="
    
    while true
    read -p "Enter table name: " table_name
    do
        case $table_name in
            "") 
                echo "Sorry, the table name can't be empty ❌"
                
                continue ;;
            *[[:space:]] | *[[:space:]]* | [[:space:]]*) 
                echo "Sorry, the table name can't have spaces ❌"
                echo "==========================="
                continue ;;
            
            [0-9]*)
                echo "Sorry, the table name can't start with a number ❌"
                echo "==========================="
                
                continue ;;
            
            *[a-zA-Z_]*[a-zA-Z_] | [a-zA-Z_]) 
                if [ -d "$table_name" ]; then 
                    echo "Table already exists ❌"
                    echo "==========================="
                    
                    continue
                else
                    table_name=$(echo "$table_name" | sed 's/ /-/g')  
                    get_num_of_cols
                    echo "==========================="
                    for (( i=0; i<$num_cols; i++ ))
                    do
                        ask_col_name
                        
                        ask_data_type
                        
                        ask_pk
                        echo "---------------------------------"
                    done
                    mkdir "$table_name"
                    touch "$table_name/data"
                    touch "$table_name/meta"

                    # insert the col names in the meta file
                    echo "${col_names[*]}" >>"$table_name/data"
                    echo "${col_names[*]}" >> "$table_name/meta"
                    echo "${data_types[*]}" >> "$table_name/meta"
                    echo "${pk_status[*]}" >> "$table_name/meta"

                    sed -i 's/ /|/g' "$table_name/meta"
                    sed -i 's/ /|/g' "$table_name/data"
                    clear
                    echo "Table $table_name created successfully." "👍"
                    echo "=================$db_name-DataBase================="
                    #echo `cat "$table_name/meta"`
                    break



                    
                fi 
                ;;
            
        esac
    done
}

create_table

. ../../main/c_db_menu.sh $db_name $usrcurrentdir

return 0
