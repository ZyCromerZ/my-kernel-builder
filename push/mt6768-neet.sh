#! /bin/bash
git checkout master

if [ ! -z "$2" ];then
    ListBranch="$2"
else
    ListBranch="merlin-q-oss-qk-n merlin-q-oss-qk-l merlin-q-oss-neutrino-1 merlin-q-oss-neutrino-3 merlin-q-oss-qk-n-dtc merlin-q-oss-qk-l-dtc merlin-q-oss-neutrino-1-dtc merlin-q-oss-neutrino-3-dtc lancelot-q-oss-qk-n"
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