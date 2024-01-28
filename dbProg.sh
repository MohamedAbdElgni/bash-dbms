#!/bin/bash

chmod +x *.sh 2> ./error.log
chmod +x ../.db/*.sh 2> ./error.log
chmod +x main/*.sh 2> ./error.log


cd main

./run.sh


