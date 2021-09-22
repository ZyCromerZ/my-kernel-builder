#! /bin/bash
git checkout master

if [ ! -z "$2" ];then
    ListBranch="$2"
else
    ListBranch="x01bd-main-q x01bd-main-r"
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
    Normal="N"
else
    repo="zyc"
    Normal="Y"
fi
if [ "$Normal" == "Y" ];then
    git push -f neet x01bd-main-q
    git push -f zyc x01bd-main-r
else
    git push -f "$repo" $ListBranch
fi

git checkout master

git branch -D $ListBranch