#!/bin/bash
destination=$1
if [[ $destination == "" ]]; then
  destination="dependencies"
fi

if [[ ! -d $destination ]]; then
    mkdir $destination
fi

while read repo; do
    spec="$repo"
    echo '::::::::::::'  $repo ':::::::' $spec
    spec_array=( $spec )
    cd $destination || exit

    dirname=(${spec_array[0]//// })
    dirnameString=$(pwd)'/'${dirname[3]}
    dirnameString=${dirnameString//.git/}

    if [ -d "${dirnameString}" ]; then
      echo "${dirnameString} already exists... reset and fetch latest"
      cd ${dirnameString} || exit
      git fetch
      git reset --hard HEAD
      git clean -fdx
      git checkout ${spec_array[1]}
      git pull # get latest in case this is a branch and not a tag
      cd ..
    else
     echo "${dirnameString} does not exist, checking out..."
     git clone ${spec_array[0]} --branch ${spec_array[1]}
    fi

    cd ..
done < dependencies.txt
