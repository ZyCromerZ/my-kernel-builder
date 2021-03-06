#! /bin/bash
git checkout master

if [ ! -z "$2" ];then
    ListBranch="$2"
else
    ListBranch="begonia-cfw-neutrino-1 begonia-cfw-neutrino-2 begonia-cfw-neutrino-3 begonia-cfw-neutrino-4 begonia-cfw-neutrino-5 begonia-cfw-neutrino-6"
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
    repo="neet"
fi
git push -f "$repo" $ListBranch

git checkout master