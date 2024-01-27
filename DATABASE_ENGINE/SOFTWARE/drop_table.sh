#!/bin/bash

PS3="Type Your Table Number To Drop: "

echo "
----------> Select Your Table Number From The Menu <--------------
"

array=(`ls`)

select choice in "${array[@]}"
do
    if [ "$REPLY" -gt "${#array[@]}" ]
    then
        echo "$REPLY not in the menu"
        continue
    else
        rm "${array[$REPLY-1]}"
        echo "${array[$REPLY-1]} Table Dropped Successfully...."
        echo
        break
    fi
done
