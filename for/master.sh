#! /bin/bash
KernelBranch="20210205/neutrino-3-custom"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="keqing-drive"
TypeBuildTag="[NON-CFW][PRIVATE][SLMK]"

CloneKernel
CloneGccten
# CompileGccKernel && CleanOut
CloneGugelClang
CompileClangKernel && CleanOut
# pullSlmk && PullLtoSlmk
# TypeBuildTag="[NON-CFW][PRIVATE-LTO-SLMK]"
# CompileClangLTOKernel && CleanOut

# CloneOldDTCClang
# pullSlmk && PullLtoSlmk
# TypeBuildTag="[NON-CFW][PRIVATE-LTO-SLMK]"
# CompileClangLTOKernel && CleanOut
