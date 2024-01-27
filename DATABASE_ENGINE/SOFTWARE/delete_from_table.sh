#!/usr/bin/bash

# get table name

echo "
    ----------> Select Your Table Number From The Menu <--------------
    "

array=($(ls))

select choice in "${array[@]}"
do
    if [ "$REPLY" -gt "${#array[@]}" ]
    then
        echo "$REPLY not in the menu"
        continue
    else
        echo "..... Your Selected ${array[$REPLY-1]} Table ...."
        table_name="${array[$REPLY-1]}"
        break
    fi
done

select choice in DELETE_ALL DELETE_ROW
do
    case $choice in
    DELETE_ALL )
        sed -i '/^[[:digit:]]/d' "$table_name"
        echo "The Table has Deleted Successfully"
        ;;

    DELETE_ROW )
        while true
        do
            read -p "input the pk of row " pk
            row=$(awk -F ':' -v pk="$pk" '{if ($1==pk) print $0}' "$table_name")
            if grep -Fxq "$row" "$table_name" &>/dev/null;
            then
                sed -i '/'"$row"'/d' "$table_name"
                echo "Row deleted successfully"
                break
            else
                echo "The PK does not exist"
                continue
            fi
        done
        break
        ;;
    * )
        echo "Type A valid Choice"
        continue
        ;;
    esac
done
