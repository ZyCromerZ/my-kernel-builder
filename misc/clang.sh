#! /bin/bash

CloneGugelClang(){
    cd $MainPath
    if [ ! -d "$ClangPath" ];then
        git clone https://github.com/ZyCromerZ/google-clang -b 9.0.4-r353983d $ClangPath --depth=1
    else
        cd "$ClangPath"
        git fetch https://github.com/ZyCromerZ/google-clang -b 9.0.4-r353983d --depth=1
        git checkout FETCH_HEAD
        git branch -D 9.0.4-r353983d
        git checkout -b 9.0.4-r353983d
    fi
    TypeBuilder="CLANG"
}