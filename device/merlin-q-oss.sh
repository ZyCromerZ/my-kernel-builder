#! /bin/bash

DEVICE="Redmi Note 9"
CODENAME="Merlin"
SaveChatID="-1001301538740"
ARCH="arm64"
TypeBuild="Stable"
DEFFCONFIG="merlin_defconfig"
GetBD=$(date +"%m%d")
GetCBD=$(date +"%Y-%m-%d")
TypeBuildTag=""
FolderUp="merlin-stock"
ExFolder=""
AnyKernelBranch="master-merlin"
FirstSendInfoLink="N"

pullALmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210405/main-ALMK
    git pull --no-commit origin 20210405/main-ALMK
    git commit -s -m 'Pull branch 20210405/main-ALMK'
    TypeBuildTag="[NON-CFW][ALMK]"
}

pullSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20210405/main-SLMK
    git pull --no-commit origin 20210405/main-SLMK
    git commit -s -m 'Pull branch 20210405/main-SLMK'
    TypeBuildTag="[NON-CFW][SLMK]"
}

PullLto(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git fetch origin 20210405/main-LTO
    git pull --no-commit origin 20210405/main-LTO
    git commit -s -m 'Pull branch 20210405/main-LTO'
    TypeBuildTag="[NON-CFW][Stock-LMK][Thin-LTO]"
}

PullLtoALmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git fetch origin 20210405/main-LTO
    git pull --no-commit origin 20210405/main-ALMK-LTO
    git commit -s -m 'Pull branch 20210405/main-ALMK-LTO'
    TypeBuildTag="[NON-CFW][ALMK][Thin-LTO]"
}

PullLtoSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git fetch origin 20210405/main-LTO
    git pull --no-commit origin 20210405/main-SLMK-LTO
    git commit -s -m 'Pull branch 20210405/main-SLMK-LTO'
    TypeBuildTag="[NON-CFW][SLMK][Thin-LTO]"
}