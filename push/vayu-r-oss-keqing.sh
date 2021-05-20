#! /bin/bash
git checkout master

if [ ! -z "$2" ];then
    ListBranch="$2"
else
    ListBranch="vayu-r-oss-neutrino-keqing vayu-r-oss-neutrino-keqing-proton vayu-r-oss-neutrino-keqing-gcc"
fi

for Branch in $ListBranch
do
    git checkout master 
    git branch -D $Branch 
    git checkout -b $Branch 
    git commit --amend -s -m "up for '$Branch'"
done

if [ ! -z "$1" ];then
    repo="$1"
else
    repo="zyc"
fi
git push -f "$repo" $ListBranch

git checkout master