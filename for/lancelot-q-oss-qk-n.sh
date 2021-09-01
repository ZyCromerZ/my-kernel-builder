#! /bin/bash
KernelBranch="20210405/qk-n"

IncludeFiles "${MainPath}/device/lancelot-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
FolderUp="letoy-qk"
doSFUp=$FolderUp
doOsdnUp=$FolderUp
TypeBuildTag="[STABLE]"

CloneKernel
CloneCompiledGccTwelve
CloneProtonClang
CompileClangKernel && pullALmk
CompileClangKernel && pullSlmk
CompileClangKernel && CleanOut


# cleanup stuff after done
cd "${MainPath}"
rm -rf *
