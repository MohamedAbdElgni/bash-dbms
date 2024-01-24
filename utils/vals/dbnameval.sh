#!/bin/bash

valDbNames() {
<<comm
This function checks it the entered db name
is valid or not 
args:db_name the action bieng proceeds
returns:flag as 0 or not
comm
  flag=0
  dbname=$1
  if [[ $dbname == "ali" ]]; then
    echo "This is $1"
    echo $flag
    else
    echo "not ali"
    ((stat+=1))
  fi
  
  
}