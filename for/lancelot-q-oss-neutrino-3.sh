#! /bin/bash
KernelBranch="20210405/neutrino-3"

IncludeFiles "${MainPath}/device/lancelot-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
FolderUp="lancelot-neutrino"
doSFUp=$FolderUp
doOsdnUp=$FolderUp
TypeBuildTag="[DTC]"

CloneKernel
CloneCompiledGccEleven
CloneOldDTCClang
CompileClangKernel && pullALmk
CompileClangKernel && pullSlmk
CompileClangKernel && CleanOut


# cleanup stuff after done
cd "${MainPath}"
rm -rf *
