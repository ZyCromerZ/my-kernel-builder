#! /bin/bash

DEVICE="Redmi Note 8 pro"
CODENAME="Begonia"
SaveChatID="-1001301538740"
ARCH="arm64"
TypeBuild="Stable"
DEFFCONFIG="begonia_user_defconfig"
GetBD=$(date +"%m%d")
GetCBD=$(date +"%Y-%m-%d")
TypeBuildTag="[CFW]"
FolderUp="begonia"
ExFolder=""
AnyKernelBranch="master-begonia"
FirstSendInfoLink="N"

pullALmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20201110/main-ALMK4
    git pull --no-commit origin 20201110/main-ALMK4
    git commit -s -m 'Pull branch 20201110/main-ALMK4'
    TypeBuild="[CFW][ALMK]"
}

pullSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20201110/main-SLMK4
    git pull --no-commit origin 20201110/main-SLMK4
    git commit -s -m 'Pull branch 20201110/main-SLMK4'
    TypeBuild="[CFW][SLMK]"
}