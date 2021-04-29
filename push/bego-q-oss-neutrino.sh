#! /bin/bash
git checkout master

if [ ! -z "$2" ];then
    ListBranch="$2"
else
    ListBranch="begonia-q-oss-neutrino-1 begonia-q-oss-neutrino-2 begonia-q-oss-neutrino-3 begonia-q-oss-neutrino-1-gcc begonia-q-oss-neutrino-2-gcc begonia-q-oss-neutrino-3-gcc begonia-q-oss-neutrino-1-dtc begonia-q-oss-neutrino-2-dtc begonia-q-oss-neutrino-3-dtc"
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