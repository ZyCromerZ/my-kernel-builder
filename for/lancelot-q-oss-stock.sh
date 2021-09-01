#! /bin/bash
KernelBranch="eleven-upstream-mod"

IncludeFiles "${MainPath}/device/lancelot-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
FolderUp="letoy-stock"
doSFUp=$FolderUp
doOsdnUp=$FolderUp
TypeBuildTag="[STOCK][ThinLTO]"

CloneKernel "--depth=1"
CloneCompiledGccTwelve
CloneProtonClang
CompileClangKernel

# cleanup stuff after done
cd "${MainPath}"
rm -rf *