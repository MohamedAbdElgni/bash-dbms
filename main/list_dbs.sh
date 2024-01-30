#!/bin/bash
shopt -s extglob
usrcurrentdir=$1
trap 'cd "$usrcurrentdir"; return' SIGINT SIGTERM
list_dbs() {
    
    dbs=( $(ls -F ../.db | grep "/" | tr / " ") )

    # Check if the array is empty
    for db in ../.db/*; do
        if [ -d "${db}" ]; then
            # extract the database name from the path with sed or awk
            db_name=$(echo "$db" | sed 's/.*\///')
            echo ""
            echo $'\360\237\222\276' "$db_name"
            echo ""
        else 
            echo "No databases found" $'\360\237\222\277'
            break
        fi
    done

    
}

list_dbs

. run.sh $usrcurrentdir

return 0

