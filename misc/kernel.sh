#! /bin/bash
# MainPath="${pwd}"
# ClangPath="${MainPath}/Clang"
# MainGCCaPath="${MainPath}/GCC64"
# MainGCCbPath="${MainPath}/GCC32"
# MainZipGCCaPath="${MainPath}/GCC64-zip"
# MainZipGCCbPath="${MainPath}/GCC32-zip"
# KernelPath="${MainPath}/Kernel"
# AnykernelPath="${MainPath}/Anykernel"
# CustomUploader="N"
# UploaderPath="${MainPath}/Uploader"
# UseSpectrum="N"
# SpectrumPath="${MainPath}/Spectrum"

. ${MainPath}/misc/clang.sh
. ${MainPath}/misc/gcc.sh

getInfo() {
    echo -e "\e[1;32m$*\e[0m"
}

getInfoErr() {
    echo -e "\e[1;41m$*\e[0m"
}

if [ ! -z "$1" ];then
    KernelRepo="$1"
    if [ "$CustomUploader" == "Y" ];then
        git clone https://$GIT_SECRET@github.com/$GIT_USERNAME/gdrive_uploader -b master "${UploaderPath}"  --depth=1 
    fi
    if [ "$UseSpectrum" == "Y" ];then
        git clone git clone https://github.com/ZyCromerZ/Spectrum -b master "${SpectrumPath}"  --depth=1 
    fi
else    
    getInfoErr "KernelRepo is missing :/"
    [ ! -z "${DRONE_BRANCH}" ] && . $MainPath/misc/bot.sh "send_info" "<b>❌ Build failed</b>%0ABranch : <b>$branch</b%0A%0ASad Boy"
    exit 1
fi

CloneKernel(){
    if [[ ! -d "${KernelPath}" ]];then
        git clone "${KernelRepo}" -b "${branch}" "${KernelPath}" "$1"
        cd "${KernelPath}"
    else
        cd "${KernelPath}"
        git fetch origin "${branch}"
        git checkout FETCH_HEAD
        git checkout -b ${branch}
    fi

    KVer=$(make kernelversion)
    HeadCommitId=$(git log --pretty=format:'%h' -n1)
    HeadCommitMsg=$(git log --pretty=format:'%s' -n1)
    GetKernelName="$(cat "./arch/$ARCH/configs/$DEFFCONFIG" | grep "CONFIG_LOCALVERSION=" | sed 's/"//g' | sed 's/CONFIG_LOCALVERSION=//g')"
}

CompileClangKernel(){
    cd "${KernelPath}"
    BUILD_START=$(date +"%s")
    make    -j${TotalCores}  O=out ARCH="$ARCH" "$DEFFCONFIG"
    if [ ! -z "$LD_LIBRARY_PATH" ];then
        MAKE+=(
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=$ClangPath/bin:$GCCaPath/bin:$GCCbPath/bin:/usr/bin:${PATH} \
                LD_LIBRARY_PATH="$ClangPath/lib64:${LD_LIBRARY_PATH}" \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                CLANG_TRIPLE=aarch64-linux-gnu-
        )
        make    -j${TotalCores}  O=out \
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=$ClangPath/bin:$GCCaPath/bin:$GCCbPath/bin:/usr/bin:${PATH} \
                LD_LIBRARY_PATH="$ClangPath/lib64:${LD_LIBRARY_PATH}" \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                CLANG_TRIPLE=aarch64-linux-gnu-
    else
        MAKE+=(
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=$ClangPath/bin:$GCCaPath/bin:$GCCbPath/bin:/usr/bin:${PATH} \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                CLANG_TRIPLE=aarch64-linux-gnu-
        )
        make    -j${TotalCores}  O=out \
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=$ClangPath/bin:$GCCaPath/bin:$GCCbPath/bin:/usr/bin:${PATH} \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                CLANG_TRIPLE=aarch64-linux-gnu-
    fi
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    if [[ ! -f $kernelDir/out/arch/$ARCH/boot/Image.gz-dtb ]];then
        MSG="<b>❌ Build failed</b>%0ABranch : <b>$branch</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s)</code>%0A%0ASad Boy"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        exit 1
    fi
    cp -af $kernelDir/out/arch/$ARCH/boot/Image.gz-dtb $AnykernelDir
    KName=$(cat "$(pwd)/arch/$ARCH/configs/$DEFFCONFIG" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )    
    ZipName="[$TypeBuilder]${TypeBuildTag}[$CODENAME]$KVer-$KName-$HeadCommitId.zip"
    MakeZip "$1"
}

CompileGccKernel(){
    cd "${KernelPath}"
    BUILD_START=$(date +"%s")
    make    -j${TotalCores}  O=out ARCH="$ARCH" "$DEFFCONFIG"
    MAKE+=(
        ARCH=$ARCH \
        SUBARCH=$ARCH \
        PATH=$gcc64Dir/bin:$gcc32Dir/bin:/usr/bin:${PATH} \
        CROSS_COMPILE=$for64- \
        CROSS_COMPILE_ARM32=$for32-
    )
    make    -j${TotalCores}  O=out \
            ARCH=$ARCH \
            SUBARCH=$ARCH \
            PATH=$GCCaPath/bin:$GCCbPath/bin:/usr/bin:${PATH} \
            CROSS_COMPILE=$for64- \
            CROSS_COMPILE_ARM32=$for32-
    
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    if [[ ! -f $kernelDir/out/arch/$ARCH/boot/Image.gz-dtb ]];then
        MSG="<b>❌ Build failed</b>%0ABranch : <b>$branch</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s)</code>%0A%0ASad Boy"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        exit 1
    fi
    cp -af $kernelDir/out/arch/$ARCH/boot/Image.gz-dtb $AnykernelDir
    KName=$(cat "$(pwd)/arch/$ARCH/configs/$DEFFCONFIG" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )    
    ZipName="[GCC]${TypeBuildTag}[$CODENAME]$KVer-$KName-$HeadCommitId.zip"
    MakeZip "$1"
}

CleanOut()
{
    rm -rf "${KernelPath}/out"
}

MakeZip(){
    cd $AnykernelDir
    if [ ! -z "$SpectrumFile" ] && [ "$UseSpectrum" == "Y" ];then
        cp -af $SpectrumPath/$SpectrumFile init.spectrum.rc && sed -i "s/persist.spectrum.kernel.*/persist.spectrum.kernel $KName/g" init.spectrum.rc
    fi
    cp -af anykernel-real.sh anykernel.sh && sed -i "s/kernel.string=.*/kernel.string=$KName-$HeadCommitId by ZyCromerZ/g" anykernel.sh

    zip -r9 "$ZipName" * -x .git README.md anykernel-real.sh .gitignore *.zip

    KernelFiles="$(pwd)/$ZipName"

    UploadKernel "$1"
    
}

UploadKernel(){
    MD5CHECK=$(md5sum "$KernelFiles" | cut -d' ' -f1)
    SHA1CHECK=$(sha1sum "${KernelFiles}" | cut -d' ' -f1)
    MSG="✅ <b>Build Success</b> %0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s) </code> %0A%0A<b>MD5 Checksum</b>%0A- <code>$MD5CHECK</code>%0A%0A<b>SHA1 Checksum</b>%0A- <code>$SHA1CHECK</code>%0A%0A<b>Zip Name</b> %0A- <code>$ZipName</code>"

    if [ "$CustomUploader" == "Y" ];then
        chmod +x "${UploaderPath}/run.sh"
        . "${UploaderPath}/run.sh" "$KernelFiles" "$FolderUp" "$GetCBD" "$ExFolder"
        . ${MainPath}/misc/bot.sh "send_info" "$MSG" "$1"
    else
        . ${MainPath}/misc/bot.sh "send_files" "$KernelFiles" "$MSG" "$1"
    fi
    if [ "$KernelDownloader" == "Y" ];then
        git clone https://$GIT_SECRETB@github.com/$GIT_USERNAME/kernel-download-generator "$KDpath"
        cd "$KDpath"
        chmod +x update.sh
        . update.sh "$KDType"
        cd ..
        rm -rf "$KDpath"
    fi

}