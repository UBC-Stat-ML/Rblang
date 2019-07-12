#!bin/bash
cwd=$(pwd)
rpath=$(which R)
cd rpath
pwd
cd library/Rblang/blang/blangSDK-master
pwd
chmod +x * setup-cli.sh
cd $cwd
