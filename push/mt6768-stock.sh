#! /bin/bash
git checkout master

if [ ! -z "$2" ];then
    ListBranch="$2"
else
    ListBranch="lancelot-q-oss-stock merlin-q-oss-stock lancelot-q-oss-stock-dtc merlin-q-oss-stock-dtc lancelot-q-oss-stock-gcc merlin-q-oss-stock-gcc"
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

git branch -D $ListBranch