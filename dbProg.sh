#!/bin/bash
shopt -s extglob
currdir=$PWD

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

chmod +x *.sh 2> ./error.log
chmod +x ../.db/*.sh 2> ./error.log
chmod +x main/*.sh 2> ./error.log

cd "$script_dir"
cd main
clear

. run.sh "$currdir"


