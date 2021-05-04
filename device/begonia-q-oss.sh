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
    TypeBuildTag="[NON-CFW][ALMK]"
}

pullSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210205/main-SLMK2
    git pull --no-commit origin 20210205/main-SLMK2
    git commit -s -m 'Pull branch 20210205/main-SLMK2'
    TypeBuildTag="[NON-CFW][SLMK]"
}

PullLto(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210205/main-LTO
    git pull --no-commit origin 20210205/main-LTO
    git commit -s -m 'Pull branch 20210205/main-LTO'
    TypeBuildTag="[NON-CFW][Stock-LMK][Thin-LTO]"
}

PullLtoALmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210205/main-ALMK2-LTO
    git pull --no-commit origin 20210205/main-ALMK2-LTO
    git commit -s -m 'Pull branch 20210205/main-ALMK2-LTO'
    TypeBuildTag="[NON-CFW][ALMK][Thin-LTO]"
}

PullLtoSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210205/main-SLMK2-LTO
    git pull --no-commit origin 20210205/main-SLMK2-LTO
    git commit -s -m 'Pull branch 20210205/main-SLMK2-LTO'
    TypeBuildTag="[NON-CFW][SLMK][Thin-LTO]"
}