#! /bin/bash
KernelBranch="eleven-upstream-mod2"

IncludeFiles "${MainPath}/device/merlin-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
FolderUp="merlin-stock"
doSFUp=$FolderUp
doOsdnUp=$FolderUp
TypeBuildTag="[STOCK]"

CloneKernel "--depth=1"
CloneCompiledGccEleven
CompileGccKernel

# cleanup stuff after done
cd "${MainPath}"
rm -rf *
