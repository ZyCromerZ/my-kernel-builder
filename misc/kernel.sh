#! /bin/bash

chmod +x ${MainPath}/misc/bot.sh

IncludeFiles ${MainPath}/misc/clang.sh
IncludeFiles ${MainPath}/misc/gcc.sh

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
        git clone https://github.com/ZyCromerZ/Spectrum -b master "${SpectrumPath}"  --depth=1 
    fi
    git clone https://github.com/ZyCromerZ/Anykernel3 -b "${AnyKernelBranch}" "${AnyKernelPath}"
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
    getInfo "clone kernel done"
    KVer=$(make kernelversion)
    HeadCommitId="$(git log --pretty=format:'%h' -n1)"
    HeadCommitMsg="$(git log --pretty=format:'%s' -n1)"
    getInfo "get some main info done"
}

CompileClangKernel(){
    cd "${KernelPath}"
    SendInfoLink
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
    if [[ ! -e $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb ]];then
        MSG="<b>❌ Build failed</b>%0ABranch : <b>$branch</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s)</code>%0A%0ASad Boy"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        exit 1
    fi
    cp -af $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb $AnyKernelPath
    KName=$(cat "${KernelPath}/arch/$ARCH/configs/$DEFFCONFIG" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )
    ZipName="[$TypeBuilder]${TypeBuildTag}[$CODENAME]$KVer-$KName-$HeadCommitId.zip"
    CompilerStatus="- <code>${ClangType}</code>%0A- <code>${gcc32Type}</code>%0A- <code>${gcc64Type}</code>"
    MakeZip "$1"
}

CompileGccKernel(){
    cd "${KernelPath}"
    SendInfoLink
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
    if [[ ! -e $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb ]];then
        MSG="<b>❌ Build failed</b>%0ABranch : <b>$branch</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s)</code>%0A%0ASad Boy"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        exit 1
    fi
    cp -af $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb $AnyKernelPath
    KName=$(cat "${KernelPath}/arch/$ARCH/configs/$DEFFCONFIG" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )
    ZipName="[GCC]${TypeBuildTag}[$CODENAME]$KVer-$KName-$HeadCommitId.zip"
    CompilerStatus="- <code>${gcc32Type}</code>%0A- <code>${gcc64Type}</code>"
    MakeZip "$1"

}

CleanOut()
{
    cd "${KernelPath}"
    git reset --hard "${HeadCommitId}"
    rm -rf "${KernelPath}/out"
}

MakeZip(){
    cd $AnyKernelPath
    if [ ! -z "$SpectrumFile" ] && [ "$UseSpectrum" == "Y" ];then
        cp -af $SpectrumPath/$SpectrumFile init.spectrum.rc && sed -i "s/persist.spectrum.kernel.*/persist.spectrum.kernel $KName/g" init.spectrum.rc
    fi
    cp -af anykernel-real.sh anykernel.sh && sed -i "s/kernel.string=.*/kernel.string=$KName-$HeadCommitId by ZyCromerZ/g" anykernel.sh

    zip -r9 "$ZipName" * -x .git README.md anykernel-real.sh .gitignore *.zip

    KernelFiles="$(pwd)/$ZipName"

    UploadKernel "$1"
    
}

UploadKernel(){
    MD5CHECK=$(md5sum "${KernelFiles}" | cut -d' ' -f1)
    SHA1CHECK=$(sha1sum "${KernelFiles}" | cut -d' ' -f1)
    MSG="✅ <b>Build Success</b> %0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s) </code> %0A%0A<b>MD5 Checksum</b>%0A- <code>$MD5CHECK</code>%0A%0A<b>SHA1 Checksum</b>%0A- <code>$SHA1CHECK</code>%0A%0A<br>Under Commit Id : Messgae</b>%0A- <code>${HeadCommitId}</code> : <code>${HeadCommitMsg}</code>%0A%0A<b>Compilers</b>%0A$CompilerStatus%0A%0A<b>Zip Name</b> %0A- <code>$ZipName</code>"

    [ ! -z "${DRONE_BRANCH}" ] && doOsdnUp="" && doSFUp=""

    if [ "${CustomUploader}" == "Y" ];then
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
    
    # always remove compiled dtb and kernel zip
    rm -rf "$KernelPath/out/arch/$ARCH/boot/Image.gz-dtb" "${KernelFiles}"
    
}

SendInfoLink(){
    if [ "$FirstSendInfoLink" == "N" ];then
        if [ ! -z "${CIRCLE_BRANCH}" ];then
            BuildNumber="${CIRCLE_BUILD_NUM}"
            GenLink="${CIRCLE_BUILD_URL}"
        fi
        if [ ! -z "${DRONE_BRANCH}" ];then
            BuildNumber="${DRONE_BUILD_NUMBER}"
            GenLink="https://cloud.drone.io/${DRONE_REPO}/${DRONE_BUILD_NUMBER}/1/2"
        fi
        MSG="🔨 New Kernel On The Way%0A%0ADevice: <code>${DEVICE}</code>%0A%0ACodename: <code>${CODENAME}</code>%0A%0ABranch: <code>${branch}</code>%0A%0ABuild Date: <code>${GetCBD}</code>%0A%0ABuild Number: <code>${BuildNumber}</code>%0A%0AHost Core Count : <code>${TotalCores} cores</code>%0A%0AKernel Version: <code>${KVer}</code>%0A%0ABuild Link Progress : ${GenLink}"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        FirstSendInfoLink="Y"
    fi
}