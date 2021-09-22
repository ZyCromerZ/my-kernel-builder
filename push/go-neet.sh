function update_fileB() {
    if [ ! -z "$1" ] && [ ! -z "$2" ] && [ ! -z "$3" ];then
        GetValue="$(cat "$3" | grep "$1")"
        GetPath=${3/"./"/"/"}
        [ "$GetValue" != "$2" ] && \
        sed -i "s/$1.*/$2"'"'"/g" "$3"
        # [ ! -z "$(git status | grep "modified" )" ] && \
        # git add "$3" && \
        # git commit -m "update builder $2"
    fi
}

ListBranch=""

git branch -D master-temp
git checkout -b master-temp

cp -af main.sh do-qk-n.sh && update_fileB 'IncludeFiles "$MainPath\/for\/${branch}.sh"' 'IncludeFiles "$MainPath\/for\/begonia-cfw-qk-l.sh' 'do-qk-n.sh' && update_fileB 'IncludeFiles "$MainPath\/for\/${branch}.sh"' 'IncludeFiles "$MainPath\/for\/begonia-cfw-qk-l.sh' 'main.sh' && ListBranch="$ListBranch do-qk-n-clang"
cp -af main.sh do-qk-l.sh && update_fileB 'IncludeFiles "$MainPath\/for\/${branch}.sh"' 'IncludeFiles "$MainPath\/for\/begonia-cfw-qk-n.sh' 'do-qk-l.sh' && update_fileB 'IncludeFiles "$MainPath\/for\/${branch}.sh"' 'IncludeFiles "$MainPath\/for\/begonia-cfw-qk-n.sh' 'main.sh' && ListBranch="$ListBranch do-qk-l-clang"
cp -af main.sh do-df-mona.sh && update_fileB 'IncludeFiles "$MainPath\/for\/${branch}.sh"' 'IncludeFiles "$MainPath\/for\/begonia-q-oss-qk-l.sh' 'do-df-mona.sh' && update_fileB 'IncludeFiles "$MainPath\/for\/${branch}.sh"' 'IncludeFiles "$MainPath\/for\/begonia-q-oss-qk-l.sh' 'main.sh' && ListBranch="$ListBranch do-df-mona-clang"
cp -af main.sh do-df-keqing.sh && update_fileB 'IncludeFiles "$MainPath\/for\/${branch}.sh"' 'IncludeFiles "$MainPath\/for\/begonia-q-oss-qk-n.sh' 'do-df-keqing.sh' && update_fileB 'IncludeFiles "$MainPath\/for\/${branch}.sh"' 'IncludeFiles "$MainPath\/for\/begonia-q-oss-qk-n.sh' 'main.sh' && ListBranch="$ListBranch do-df-keqing-clang"

git add . && git commit -s -m 'AUTO copyfiles for uWu'

for Branch in $ListBranch
do
    git checkout master-temp
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
git branch -D master-temp

git branch -D $ListBranch

# repo : do-tercydux-tiris-clang
# repo : do-tercydux-santuy-clang
# repo : do-tercydux-hareudang-clang
# repo : do-df-mona-clang
# repo : do-df-keqing-clang
# repo : do-qk-n-clang
# repo : do-qk-l-clang