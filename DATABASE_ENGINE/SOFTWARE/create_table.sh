#!/bin/bash

# ------ list tables to the user ---------------
echo " 
        ------------------> Already Existing Tables <------------------ 
        "
ls -s 

#----------- let user create a valid table name not existing in the list of tables --------
while true; do
    # read the input 
    read -p "Enter Your Table Name To Create: "
    table_name=$REPLY

    case $table_name in 
        "") 
            echo "Sorry, the name can't be empty"
            echo "==========================="
            continue;;
        *[[:space:]] | *[[:space:]]* | [[:space:]]*) 
            echo "Sorry, the name of the table can't have any spaces"
            echo "==========================="
            continue;;
        [0-9]*) 
            echo "Sorry, the name can't start with integers"
            echo "==========================="
            continue;;
        *[a-zA-Z_]*[a-zA-Z_] | [a-zA-Z_]) 
            if grep -q "$table_name" <(ls -F | grep /)
            then
                echo "Oh my god, Looks like the Table Already Exists"
                continue
            else
                touch "$table_name"
            fi
            echo "You Created Your Table Successfully "
            break;;
        *) 
            echo "Invalid input, write a valid name"
            echo "==========================="
            continue;;
    esac
done

#---------- let the user insert data to the table--------------
#1) read the number of fields
while true; do
    read -p "Insert the number of fields for $table_name table:  "
    fields_num=$REPLY

    case $fields_num in 
        0 ) 
            echo "The table number of fields can't be $fields_num"
            continue;;
        *[1-9] | *[1-9]*[0-9] )
            echo "The table number of fields is $fields_num"
            break;;
        * )
            echo "Write a valid number"
            continue;;
    esac
done

# Initialize variables
row_name=""
row_type=""

#2) insert the meta data 
echo " 
    ---------------->Insert Your Meta Data For $table_name Table <----------------- "

echo " First Insert Column Names "

echo " 
    ------------------> Field Number 1 Is The Primary Key <------------------- "

for ((i=2; i<=$fields_num; i++)); do
    # valid for the input name
    while true; do
        # -----------read the input------------
        read -p "Column number $i name is: " col_name
        case $col_name in 
            "") 
                echo "Sorry, the name can't be empty"
                echo "==========================="
                continue;;
            *[[:space:]] | *[[:space:]]* | [[:space:]]*) 
                echo "Sorry, the name can't have any spaces"
                echo "==========================="
                continue;;
            [0-9]*) 
                echo "Sorry, the name can't start with integers"
                echo "==========================="
                continue;;
            *[a-zA-Z_]*[a-zA-Z0-9_] | [a-zA-Z_]) 
                # if the name exists in the list
                if grep -q "$col_name" <(head -1 "$table_name")
                then
                    echo "Oh my god, Looks like $col_name Column name is Already Exist"
                    continue
                else
                    if [ $i -eq 2 ]; then
                        row_name+="id : $col_name"
                    else
                        row_name+=" : $col_name"
                    fi
                    break
                fi
                ;;
            # if name has a special character
            *) 
                echo "Invalid input, The Name Can't have a Special Character"
                echo "==========================="
                continue;;
        esac
    done
done

echo "$row_name" >> "$table_name"

#3) insert the type of the data 
echo " 
    Second Insert Column Types
"


echo "
    ------------------> Field Number 1 Type is Integer <-------------- "

for ((i=2; i<=$fields_num; i++)); do
    echo " ==> Type Your Choice For Field $i : "

    # support string and int 
    select choice in string integer; do
        case $choice in
            string )
                if [ $i -eq 2 ]; then 
                    row_type+="integer : string"
                else
                    row_type+=" : string"
                fi
                break;;
            integer ) 
                if [ $i -eq 2 ]; then 
                    row_type+="integer : integer"
                else
                    row_type+=" : integer"
                fi
                break;;
            * ) 
                echo "Only 1 and 2 are available"
                continue;;
        esac
    done
done

echo "$row_type" >> "$table_name"

echo "
Your Table Meta Data is :
$row_name
$row_type
"

cd - > /dev/null 2>&1

