#!/usr/bin/bash
select choice in CREATE_DB LIST_DB CONNECT_DB DROP_DB
do 
case $choice in
CREATE_DB )
    echo "Creating DataBase...."
    source ./create_db.sh
    ;;
LIST_DB )
    echo "Listing DataBase...."
    source ./list_db.sh
    ;;
CONNECT_DB )
    echo "Connecting DataBase...."
    source ./connect_db.sh
    ;;
DROP_DB )
    echo "Drop DataBase...."
    ./drop_db.sh
    ;;
esac
done