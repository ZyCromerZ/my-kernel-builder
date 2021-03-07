#! /bin/bash

CloneGCCOld(){
    cd "${MainPath}"
    GCCaPath="${MainGCCaPath}"
    if [ ! -d "$GCCaPath" ];then
        git clone https://github.com/ZyCromerZ/aarch64-linux-android-4.9 -b android-10.0.0_r47 $GCCaPath --depth=1
    else
        cd "$GCCaPath"
        git fetch https://github.com/ZyCromerZ/aarch64-linux-android-4.9 -b android-10.0.0_r47 --depth=1
        git checkout FETCH_HEAD
        git branch -D android-10.0.0_r47
        git checkout -b android-10.0.0_r47
    fi
    for64=aarch64-linux-android
    cd "${MainPath}"
    GCCbPath="${MainGCCbPath}"
    if [ ! -d "$GCCbPath" ];then
        git clone https://github.com/ZyCromerZ/arm-linux-androideabi-4.9 -b android-10.0.0_r47 $GCCbPath --depth=1
    else
        cd "$GCCbPath"
        git fetch https://github.com/ZyCromerZ/arm-linux-androideabi-4.9 -b android-10.0.0_r47 --depth=1
        git checkout FETCH_HEAD
        git branch -D android-10.0.0_r47
        git checkout -b android-10.0.0_r47
    fi
    for32=arm-linux-androideabi
    GetGccVersion
}

CloneGcc10(){
    cd "${MainPath}"
    GCCaPath="$MainZipGCCaPath"
    GCCbPath="$MainZipGCCbPath"
    mkdir $GCCaPath
    mkdir $GCCbPath
    if [ ! -e "${MainPath}/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz" ];then
        wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz
        tar -xf gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz -C $GCCbPath
    fi
    GCCbPath="${GCCbPath}/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf"
    for32=arm-none-linux-gnueabihf
    if [ ! -e "${MainPath}/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz" ];then
        wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz
        tar -xf gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz -C $GCCaPath
    fi
    GCCaPath="${GCCaPath}/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf"
    for64=aarch64-none-elf
    GetGccVersion
}

GetGccVersion()
{
    if [ -e $GCCaPath/bin/$for32-gcc ];then
        gcc32Type="$($GCCaPath/bin/$for32-gcc --version | head -n 1)"
    else
        cd $GCCaPath
        gcc32Type=$(git log --pretty=format:'%h: %s' -n1)
        cd $mainDir
    fi
    if [ -e $GCCbPath/bin/$for64-gcc ];then
        gcc64Type="$($GCCbPath/bin/$for64-gcc --version | head -n 1)"
    else
        cd $GCCbPath
        gcc64Type=$(git log --pretty=format:'%h: %s' -n1)
        cd $mainDir
    fi
}