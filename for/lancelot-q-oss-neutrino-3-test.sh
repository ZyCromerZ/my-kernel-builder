#! /bin/bash
KernelBranch="eleven-upstream-mod"

IncludeFiles "${MainPath}/device/lancelot-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
FolderUp="keqing-drive"
TypeBuildTag="[TEST][D]"

CloneKernel
CloneCompiledGccTwelve
#  && PullLtoALmk
CompileGccKernel && CleanOut


# cleanup stuff after done
cd "${MainPath}"
rm -rf *
