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
    ClangType="$($ClangPath/bin/clang --version | head -n 1)"
}

CloneOldDTCClang(){
    cd $MainPath
    if [ ! -d "$ClangPath" ];then
        git clone https://github.com/nibaji/DragonTC-8.0 -b master $ClangPath --depth=1
    else
        cd "$ClangPath"
        git fetch https://github.com/nibaji/DragonTC-8.0 -b master --depth=1
        git checkout FETCH_HEAD
        git branch -D master
        git checkout -b master
    fi
    TypeBuilder="DTC-OLD"
    ClangType="$($ClangPath/bin/clang --version | head -n 1)"
}

CloneDTCClang(){
    cd $MainPath
    if [ ! -d "$ClangPath" ];then
        git clone https://github.com/NusantaraDevs/DragonTC -b 10.0 $ClangPath --depth=1
    else
        cd "$ClangPath"
        git fetch https://github.com/NusantaraDevs/DragonTC -b 10.0 --depth=1
        git checkout FETCH_HEAD
        git branch -D 10.0
        git checkout -b 10.0
    fi
    TypeBuilder="DTC"
    ClangType="$($ClangPath/bin/clang --version | head -n 1)"
}
