#!/bin/bash

cd ../DATA_META

PS3="Type Your Number To Drop:  "
echo "Select The DataBase you Want Drop"

array=(`ls -F | grep / | tr / " "`)

select choice in "${array[@]}"
do
    if [ "$REPLY" -gt "${#array[@]}" ]
    then
        echo "$REPLY not on the menu"
        continue
    else
        rm -r "${array[$REPLY-1]}"
        echo "
        --------Your ${array[$REPLY-1]} DB deleted Successfully---------"
        echo "
        ================================================================"
        
        break
    fi
done

cd &>/dev/null
