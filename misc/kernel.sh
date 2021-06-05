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
        git clone https://${GIT_SECRET}@github.com/${GIT_USERNAME}/uploader-kernel-private -b master "${UploaderPath}"  --depth=1
    fi
    if [ "$UseSpectrum" == "Y" ];then
        git clone https://github.com/ZyCromerZ/Spectrum -b master "${SpectrumPath}"  --depth=1 
    fi
    git clone https://github.com/ZyCromerZ/Anykernel3 -b "${AnyKernelBranch}" "${AnyKernelPath}"
else    
    getInfoErr "KernelRepo is missing :/"
    [ ! -z "${DRONE_BRANCH}" ] && . $MainPath/misc/bot.sh "send_info" "<b>❌ Build failed</b>%0ABranch : <b>${KernelBranch}</b%0A%0ASad Boy"
    exit 1
fi

CloneKernel(){
    if [[ ! -d "${KernelPath}" ]];then
        if [ ! -z "$1" ];then
            git clone "${KernelRepo}" -b "${KernelBranch}" "${KernelPath}" "$1"
        else
            git clone "${KernelRepo}" -b "${KernelBranch}" "${KernelPath}"
        fi
        cd "${KernelPath}"
    else
        cd "${KernelPath}"
        if [ ! -z "${KernelBranch}" ];then
            getInfo "clone balik?"
            if [ ! -z "$1" ];then
                git fetch origin "${KernelBranch}" "$1"
            else
                git fetch origin "${KernelBranch}"
            fi
            git checkout FETCH_HEAD
            git branch -D "${KernelBranch}"
            git checkout -b "${KernelBranch}"
        fi
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
    if [ -d "${ClangPath}/lib64" ];then
        MAKE+=(
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
                LD_LIBRARY_PATH="${ClangPath}/lib64:${LD_LIBRARY_PATH}" \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                CLANG_TRIPLE=aarch64-linux-gnu-
        )
        make    -j${TotalCores}  O=out \
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
                LD_LIBRARY_PATH="${ClangPath}/lib64:${LD_LIBRARY_PATH}" \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                CLANG_TRIPLE=aarch64-linux-gnu-
    else
        MAKE+=(
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                CLANG_TRIPLE=aarch64-linux-gnu-
        )
        make    -j${TotalCores}  O=out \
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                CLANG_TRIPLE=aarch64-linux-gnu-
    fi
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    if [[ ! -e $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb ]];then
        MSG="<b>❌ Build failed</b>%0ABranch : <b>${KernelBranch}</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s)</code>%0A%0ASad Boy"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        exit 1
    fi
    cp -af $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb $AnyKernelPath
    KName=$(cat "${KernelPath}/arch/$ARCH/configs/$DEFFCONFIG" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )
    ZipName="[$GetBD][$TypeBuilder]${TypeBuildTag}[$CODENAME]$KVer-$KName-$HeadCommitId.zip"
    CompilerStatus="- <code>${ClangType}</code>%0A- <code>${gcc32Type}</code>%0A- <code>${gcc64Type}</code>"
    if [ ! -z "$1" ];then
        MakeZip "$1"
    else
        MakeZip
    fi
}

CompileClangLTOKernel(){
    cd "${KernelPath}"
    SendInfoLink
    BUILD_START=$(date +"%s")
    make    -j${TotalCores}  O=out ARCH="$ARCH" "$DEFFCONFIG"
    if [ -d "${ClangPath}/lib64" ];then
        MAKE+=(
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
                LD_LIBRARY_PATH="${ClangPath}/lib64:${LD_LIBRARY_PATH}" \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                AS=llvm-as \
                NM=llvm-nm \
                STRIP=llvm-strip \
                OBJDUMP=llvm-objdump \
                OBJSIZE=llvm-size \
                READELF=llvm-readelf \
                HOSTCC=clang \
                HOSTCXX=clang++ \
                HOSTAR=llvm-ar \
                HOSTLD=ld.lld \
                LD=ld.lld \
                CLANG_TRIPLE=aarch64-linux-gnu-
        )
        make    -j${TotalCores}  O=out \
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
                LD_LIBRARY_PATH="${ClangPath}/lib64:${LD_LIBRARY_PATH}" \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                AS=llvm-as \
                NM=llvm-nm \
                STRIP=llvm-strip \
                OBJDUMP=llvm-objdump \
                OBJSIZE=llvm-size \
                READELF=llvm-readelf \
                HOSTCC=clang \
                HOSTCXX=clang++ \
                HOSTAR=llvm-ar \
                HOSTLD=ld.lld \
                LD=ld.lld \
                CLANG_TRIPLE=aarch64-linux-gnu-
    else
        MAKE+=(
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                AS=llvm-as \
                NM=llvm-nm \
                STRIP=llvm-strip \
                OBJDUMP=llvm-objdump \
                OBJSIZE=llvm-size \
                READELF=llvm-readelf \
                HOSTCC=clang \
                HOSTCXX=clang++ \
                HOSTAR=llvm-ar \
                HOSTLD=ld.lld \
                LD=ld.lld \
                CLANG_TRIPLE=aarch64-linux-gnu-
        )
        make    -j${TotalCores}  O=out \
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
                CC="ccache clang" \
                CROSS_COMPILE=$for64- \
                CROSS_COMPILE_ARM32=$for32- \
                AS=llvm-as \
                NM=llvm-nm \
                STRIP=llvm-strip \
                OBJDUMP=llvm-objdump \
                OBJSIZE=llvm-size \
                READELF=llvm-readelf \
                HOSTCC=clang \
                HOSTCXX=clang++ \
                HOSTAR=llvm-ar \
                HOSTLD=ld.lld \
                LD=ld.lld \
                CLANG_TRIPLE=aarch64-linux-gnu-
    fi
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    if [[ ! -e $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb ]];then
        MSG="<b>❌ Build failed</b>%0ABranch : <b>${KernelBranch}</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s)</code>%0A%0ASad Boy"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        exit 1
    fi
    cp -af $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb $AnyKernelPath
    KName=$(cat "${KernelPath}/arch/$ARCH/configs/$DEFFCONFIG" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )
    ZipName="[$GetBD][$TypeBuilder][LTO]${TypeBuildTag}[$CODENAME]$KVer-$KName-$HeadCommitId.zip"
    CompilerStatus="- <code>${ClangType}</code>%0A- <code>${gcc32Type}</code>%0A- <code>${gcc64Type}</code>"
    if [ ! -z "$1" ];then
        MakeZip "$1"
    else
        MakeZip
    fi
}

CompileGccKernel(){
    cd "${KernelPath}"
    SendInfoLink
    BUILD_START=$(date +"%s")
    make    -j${TotalCores}  O=out ARCH="${ARCH}" "${DEFFCONFIG}"
    MAKE+=(
        ARCH=$ARCH \
        SUBARCH=$ARCH \
        PATH=${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
        CROSS_COMPILE=$for64- \
        CROSS_COMPILE_ARM32=$for32-
    )
    make    -j${TotalCores}  O=out \
            ARCH=$ARCH \
            SUBARCH=$ARCH \
            PATH=${GCCaPath}/bin:${GCCbPath}/bin:/usr/bin:${PATH} \
            CROSS_COMPILE=$for64- \
            CROSS_COMPILE_ARM32=$for32-
    
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    if [[ ! -e $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb ]];then
        MSG="<b>❌ Build failed</b>%0ABranch : <b>${KernelBranch}</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s)</code>%0A%0ASad Boy"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        exit 1
    fi
    cp -af $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb $AnyKernelPath
    KName=$(cat "${KernelPath}/arch/${ARCH}/configs/${DEFFCONFIG}" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )
    ZipName="[$GetBD][GCC]${TypeBuildTag}[$CODENAME]$KVer-$KName-$HeadCommitId.zip"
    CompilerStatus="- <code>${gcc32Type}</code>%0A- <code>${gcc64Type}</code>"
    if [ ! -z "$1" ];then
        MakeZip "$1"
    else
        MakeZip
    fi

}

CompileProtonClangKernel(){
    cd "${KernelPath}"
    SendInfoLink
    BUILD_START=$(date +"%s")
    make    -j${TotalCores}  O=out ARCH="$ARCH" "$DEFFCONFIG"
    if [ -d "${ClangPath}/lib64" ];then
        MAKE+=(
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:/usr/bin:${PATH} \
                LD_LIBRARY_PATH="${ClangPath}/lib64:${LD_LIBRARY_PATH}" \
                CC="ccache clang" \
                CROSS_COMPILE=aarch64-linux-gnu- \
                CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                AR=llvm-ar \
                NM=llvm-nm \
                OBJCOPY=llvm-objcopy \
                OBJDUMP=llvm-objdump \
                STRIP=llvm-strip \
                LD=ld.lld \
                CLANG_TRIPLE=aarch64-linux-gnu-
        )
        make    -j${TotalCores}  O=out \
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:/usr/bin:${PATH} \
                LD_LIBRARY_PATH="${ClangPath}/lib64:${LD_LIBRARY_PATH}" \
                CROSS_COMPILE=aarch64-linux-gnu- \
                CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                AR=llvm-ar \
                NM=llvm-nm \
                OBJCOPY=llvm-objcopy \
                OBJDUMP=llvm-objdump \
                STRIP=llvm-strip \
                LD=ld.lld \
                CLANG_TRIPLE=aarch64-linux-gnu-
    else
        MAKE+=(
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:/usr/bin:${PATH} \
                CC="ccache clang" \
                CROSS_COMPILE=aarch64-linux-gnu- \
                CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                AR=llvm-ar \
                NM=llvm-nm \
                OBJCOPY=llvm-objcopy \
                OBJDUMP=llvm-objdump \
                STRIP=llvm-strip \
                LD=ld.lld \
                CLANG_TRIPLE=aarch64-linux-gnu-
        )
        make    -j${TotalCores}  O=out \
                ARCH=$ARCH \
                SUBARCH=$ARCH \
                PATH=${ClangPath}/bin:/usr/bin:${PATH} \
                CC="ccache clang" \
                CROSS_COMPILE=aarch64-linux-gnu- \
                CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                AR=llvm-ar \
                NM=llvm-nm \
                OBJCOPY=llvm-objcopy \
                OBJDUMP=llvm-objdump \
                STRIP=llvm-strip \
                LD=ld.lld \
                CLANG_TRIPLE=aarch64-linux-gnu-
    fi
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    if [[ ! -e $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb ]];then
        MSG="<b>❌ Build failed</b>%0ABranch : <b>${KernelBranch}</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s)</code>%0A%0ASad Boy"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        exit 1
    fi
    cp -af $KernelPath/out/arch/$ARCH/boot/Image.gz-dtb $AnyKernelPath
    KName=$(cat "${KernelPath}/arch/$ARCH/configs/$DEFFCONFIG" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )
    ZipName="[$GetBD][$TypeBuilder]${TypeBuildTag}[$CODENAME]$KVer-$KName-$HeadCommitId.zip"
    CompilerStatus="- <code>${ClangType}</code>"
    if [ ! -z "$1" ];then
        MakeZip "$1"
    else
        MakeZip
    fi
}

CleanOut()
{
    cd "${KernelPath}"
    git reset --hard "${HeadCommitId}"
    rm -rf "${KernelPath}/out"
    ccache -c
    ccache -C
}

MakeZip(){
    cd $AnyKernelPath
    if [ ! -z "$spectrumFile" ] && [ "$UseSpectrum" == "Y" ];then
        cp -af $SpectrumPath/$spectrumFile init.spectrum.rc && sed -i "s/persist.spectrum.kernel.*/persist.spectrum.kernel $KName/g" init.spectrum.rc
    fi
    cp -af anykernel-real.sh anykernel.sh && sed -i "s/kernel.string=.*/kernel.string=$KName-$HeadCommitId by ZyCromerZ/g" anykernel.sh
    if [ "$CODENAME" == "Vayu" ];then
        cp -af $KernelPath/out/arch/$ARCH/boot/dtbo.img $AnyKernelPath
    fi
    # update zip name :v
    ZipName=${ZipName/"--"/"-"}
    zip -r9 "$ZipName" * -x .git README.md anykernel-real.sh .gitignore *.zip

    KernelFiles="$(pwd)/$ZipName"

    if [ ! -z "$1" ];then
        UploadKernel "$1"
    else
        UploadKernel "$1"
    fi
    
}

UploadKernel(){
    MD5CHECK=$(md5sum "${KernelFiles}" | cut -d' ' -f1)
    SHA1CHECK=$(sha1sum "${KernelFiles}" | cut -d' ' -f1)
    MSG="✅ <b>Build Success</b>%0A- <code>$((DIFF / 60)) minute(s) $((DIFF % 60)) second(s) </code>%0A%0A<b>MD5 Checksum</b>%0A- <code>$MD5CHECK</code>%0A%0A<b>SHA1 Checksum</b>%0A- <code>$SHA1CHECK</code>%0A%0A<b>Under Commit Id : Message</b>%0A- <code>${HeadCommitId}</code> : <code>${HeadCommitMsg}</code>%0A%0A<b>Compilers</b>%0A$CompilerStatus%0A%0A<b>Zip Name</b>%0A- <code>$ZipName</code>"

    [ ! -z "${DRONE_BRANCH}" ] && doOsdnUp="" && doSFUp=""

    if [ "${CustomUploader}" == "Y" ];then
        cd $UploaderPath
        chmod +x "${UploaderPath}/run.sh"
        . "${UploaderPath}/run.sh" "$KernelFiles" "$FolderUp" "$GetCBD" "$ExFolder"
        if [ ! -z "$1" ];then
            UploadKernel "$1"
            . ${MainPath}/misc/bot.sh "send_info" "$MSG" "$1"
        else
            . ${MainPath}/misc/bot.sh "send_info" "$MSG"
        fi
    else
        if [ ! -z "$1" ];then
            . ${MainPath}/misc/bot.sh "send_files" "$KernelFiles" "$MSG" "$1"
        else
            . ${MainPath}/misc/bot.sh "send_files" "$KernelFiles" "$MSG"
        fi
    fi
    if [ "$KernelDownloader" == "Y" ] && [ ! -z "${KDType}" ];then
        git clone https://$GIT_SECRETB@github.com/$GIT_USERNAME/kernel-download-generator "$KDpath"
        cd "$KDpath"
        chmod +x "${KDpath}/update.sh"
        . "${KDpath}/update.sh" "${KDType}"
        cd "$MainPath"
        rm -rf "$KDpath"
    fi
    
    # always remove compiled dtb and kernel zip
    rm -rf "$KernelPath/out/arch/$ARCH/boot/Image.gz-dtb"
    getInfo "remove kernel dtb files done"
    rm -rf "${KernelFiles}"
    getInfo "remove kernel zip files done"
    
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
        MSG="🔨 New Kernel On The Way%0A%0ADevice: <code>${DEVICE}</code>%0A%0ACodename: <code>${CODENAME}</code>%0A%0ABranch: <code>${KernelBranch}</code>%0A%0ABuild Date: <code>${GetCBD}</code>%0A%0ABuild Number: <code>${BuildNumber}</code>%0A%0AHost Core Count : <code>${TotalCores} cores</code>%0A%0AKernel Version: <code>${KVer}</code>%0A%0ABuild Link Progress : ${GenLink}"
        . $MainPath/misc/bot.sh "send_info" "$MSG"
        FirstSendInfoLink="Y"
    fi
}