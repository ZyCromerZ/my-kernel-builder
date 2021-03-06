#! /bin/bash
MainPath="$(pwd)"
ClangPath="${MainPath}/Clang"
MainGCCaPath="${MainPath}/GCC64"
MainGCCbPath="${MainPath}/GCC32"
MainZipGCCaPath="${MainPath}/GCC64-zip"
MainZipGCCbPath="${MainPath}/GCC32-zip"
KernelPath="${MainPath}/Kernel"
AnykernelPath="${MainPath}/Anykernel"
CustomUploader="N"
UploaderPath="${MainPath}/Uploader"
FolderUp=""
ExFolder=""
UseSpectrum="N"
SpectrumPath="${MainPath}/Spectrum"
SpectrumFile="None"
KernelDownloader='N'
KDpath="${MainPath}/Kernel-Downloader"
KDType=""

export DEBIAN_FRONTEND=noninteractive
export KBUILD_BUILD_USER="ZyCromerZ"
[ ! -z "${CIRCLE_BRANCH}" ] && branch="${CIRCLE_BRANCH}" && export KBUILD_BUILD_HOST="Circleci-server"
[ ! -z "${DRONE_BRANCH}" ] && branch="${DRONE_BRANCH}" && export KBUILD_BUILD_HOST="Droneci-server"

# just fix for dtc clang
check=$(ls /usr/lib/x86_64-linux-gnu | grep libisl.so -m1)
if [ ! -z "$check" ]; then if [ "$check" != "libisl.so.15" ]; then cp -af /usr/lib/x86_64-linux-gnu/$check /usr/lib/x86_64-linux-gnu/libisl.so.15; fi; fi
check=$(ls /usr/lib/x86_64-linux-gnu | grep libz3.so -m1)
if [ ! -z "$check" ]; then if [ "$check" != "libz3.so.4.8" ]; then cp -af /usr/lib/x86_64-linux-gnu/$check /usr/lib/x86_64-linux-gnu/libz3.so.4.8; fi; fi
check=""

chmod +x $MainPath/for/${branch}.sh && . "$MainPath/for/${branch}.sh"