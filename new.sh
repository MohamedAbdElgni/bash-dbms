#!/bin/bash
shopt -s extglob
currdir=$PWD

echo $currdir


script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#echo $script_dir

echo "${BASH_SOURCE}"

