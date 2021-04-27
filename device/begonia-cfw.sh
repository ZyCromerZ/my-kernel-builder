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
    TypeBuildTag="[CFW][ALMK]"
}

pullSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20201110/main-SLMK4
    git pull --no-commit origin 20201110/main-SLMK4
    git commit -s -m 'Pull branch 20201110/main-SLMK4'
    TypeBuildTag="[CFW][SLMK]"
}

PullLto(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20201110/main-LTO
    git pull --no-commit origin 20201110/main-LTO
    git commit -s -m 'Pull branch 20201110/main-LTO'
    TypeBuildTag="[CFW][Stock-LMK][Thin-LTO]"
}

PullLtoALmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20201110/main-LTO
    git pull --no-commit origin 20201110/main-ALMK4-LTO
    git commit -s -m 'Pull branch 20201110/main-ALMK4-LTO'
    TypeBuildTag="[CFW][ALMK][Thin-LTO]"
}

PullLtoSlmk(){
    [[ "$(pwd)" != "${KernelPath}" ]] && cd "${KernelPath}"
    git reset --hard $HeadCommitId
    git fetch origin 20201110/main-LTO
    git pull --no-commit origin 20201110/main-SLMK4-LTO
    git commit -s -m 'Pull branch 20201110/main-SLMK4-LTO'
    TypeBuildTag="[CFW][SLMK][Thin-LTO]"
}