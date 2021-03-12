#! /bin/bash

DEVICE="Redmi 9"
CODENAME="Lancelot"
SaveChatID="-1001301538740"
ARCH="arm64"
TypeBuild="Stable"
DEFFCONFIG="lancelot_defconfig"
GetBD=$(date +"%m%d")
GetCBD=$(date +"%Y-%m-%d")
TypeBuildTag=""
FolderUp="letoy-stock"
ExFolder=""
AnyKernelBranch="master-lancelot"
FirstSendInfoLink="N"

pullALmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210228/main-ALMK
    git pull --no-commit origin 20210228/main-ALMK
    git commit -s -m 'Pull branch 20210228/main-ALMK'
    TypeBuildTag="[NON-CFW][ALMK]"
}

pullSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210228/main-SLMK
    git pull --no-commit origin 20210228/main-SLMK
    git commit -s -m 'Pull branch 20210228/main-SLMK'
    TypeBuildTag="[NON-CFW][SLMK]"
}