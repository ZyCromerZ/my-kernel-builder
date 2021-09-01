#! /bin/bash
KernelBranch="20210405/neutrino-3"

IncludeFiles "${MainPath}/device/merlin-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
FolderUp="merlin-neutrino"
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
