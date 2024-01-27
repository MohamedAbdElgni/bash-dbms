#!/bin/bash



PS3="Type Your DB Number To Connect with :   "
echo "----------------> Select Your DB Number From The Menu <----------------"

cd ../DATA_META
array=(`ls -F | grep / | tr / " "`)

select choice in ${array[*]}
do
    if [ $REPLY -gt ${#array[*]} ]
    then
        echo "$REPLY not on the menu"
        continue
    else
        cd ../DATA_META/${array[${REPLY}-1]}
        echo "
        --------Your are connected to ${array[${REPLY}-1]} DB Successfully---------"
        echo "
        ================================================================"
        
        break
    fi
done


echo
PS3="Type Your Choice Number"

select choice in Create_Table List_Table Drop_Table Insert_in_Table Select_From_Table Delete_From_Table Update_From_Table
do
    case $choice in 
        Create_Table )
        echo "
        Creating Table......."
            source ../../SOFTWARE/create_table.sh
        ;;
                List_Table )
        echo "
        Listing Table......."
        source ../../SOFTWARE/list_table.sh
        ;;
                Drop_Table )
        echo "
            Dropping Table......."
        source ../../SOFTWARE/drop_table.sh
        ;;
                Insert_in_Table )
        echo "
        Inserting Table......."
        source ../../SOFTWARE/insert_in_table.sh
        ;;
                Select_From_Table )
        echo "
        Selecting Table......."
        source ../../SOFTWARE/select_from_table.sh
        ;;
                Delete_From_Table )
        echo "
        Deleting Table......."
        source ../../SOFTWARE/delete_from_table.sh
        ;;
                Update_From_Table )
        echo "
        Updating Table......."
        source ../../SOFTWARE/update_from_table.sh
        ;;

        * )
        echo " Not a propriate choice try again "
    esac
done

cd &>/dev/null
