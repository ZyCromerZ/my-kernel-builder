#! /bin/bash
git checkout master

if [ ! -z "$2" ];then
    ListBranch="$2"
else
    ListBranch="lancelot-q-oss-qk-l lancelot-q-oss-neutrino-1 lancelot-q-oss-neutrino-2 lancelot-q-oss-neutrino-3 lancelot-q-oss-qk-n-dtc lancelot-q-oss-qk-l-dtc lancelot-q-oss-neutrino-1-dtc lancelot-q-oss-neutrino-2-dtc lancelot-q-oss-neutrino-3-dtc"
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