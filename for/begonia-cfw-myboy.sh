#! /bin/bash
KernelBranch="20201110/neutrino-3"

IncludeFiles "${MainPath}/device/begonia-cfw.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="keqing-drive"
TypeBuildTag="[CFW][Stock-LMK]"

CloneKernel
# CloneCompiledGccEleven
CloneCompiledGccTwelve
CloneGugelClang
PullLtoSlmk
CompileClangKernel && CleanOut
PullSlmk
CompileGccKernel && CleanOut

# cleanup stuff after done
cd "${MainPath}"
rm -rf *