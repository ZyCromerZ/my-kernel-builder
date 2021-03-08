#! /bin/bash

DEVICE="Redmi Note 8 pro"
CODENAME="Begonia"
SaveChatID="-1001301538740"
ARCH="arm64"
TypeBuild="Stable"
DEFFCONFIG="begonia_user_defconfig"
GetBD=$(date +"%m%d")
GetCBD=$(date +"%Y-%m-%d")
TypeBuildTag="[NON-CFW]"
FolderUp="begonia"
ExFolder=""
AnyKernelBranch="master-begonia"
FirstSendInfoLink="N"

pullALmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210205/main-ALMK2
    git pull --no-commit origin 20210205/main-ALMK2
    git commit -s -m 'Pull branch 20210205/main-ALMK2'
    TypeBuild="[NON-CFW][ALMK]"
}

pullSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210205/main-SLMK2
    git pull --no-commit origin 20210205/main-SLMK2
    git commit -s -m 'Pull branch 20210205/main-SLMK2'
    TypeBuild="[NON-CFW][SLMK]"
}