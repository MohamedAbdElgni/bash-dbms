#!/bin/bash

valDbNames() {
<<comm
This function checks it the entered db name
is valid or not 
args:db_name the action bieng proceeds
returns:flag as 0 or not
comm
  flag=0
  db_name=$1
  if [[ $db_name == "ali" ]]; then
    echo "This is $1"
    echo $flag
    else
    echo "not ali"
    ((flag+=1))
  fi
  
  
}