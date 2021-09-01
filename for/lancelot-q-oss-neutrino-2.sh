#! /bin/bash
KernelBranch="20210405/neutrino-2"

IncludeFiles "${MainPath}/device/lancelot-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
FolderUp="letoy-neutrino"
doSFUp=$FolderUp
TypeBuildTag="[STABLE]"

CloneKernel
CloneCompiledGccTwelve
CloneProtonClang && PullLto
CompileClangKernel && PullLtoALmk
CompileClangKernel && PullLtoSlmk
CompileClangKernel && CleanOut


# cleanup stuff after done
cd "${MainPath}"
rm -rf *
