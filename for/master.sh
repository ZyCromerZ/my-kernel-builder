#! /bin/bash
# KernelBranch="20210205/neutrino-3-custom"
KernelBranch="lineage-18.1-R-wifitags"

# IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
IncludeFiles "${MainPath}/device/x01bd.sh"
CustomUploader="Y"
# IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/x01bd_kernel"

FolderUp="keqing-drive"
# TypeBuildTag="[NON-CFW][PRIVATE][SLMK][FULL-LTO]"
# TypeBuildTag="[NON-CFW][Stock-LMK]"

CloneKernel "--depth=1"
# # CloneGccten
# # CloneCompiledGcc
# CloneCompiledGccEleven
# # CompileGccKernel && CleanOut
# CloneGugelClang
# CompileClangKernel && CleanOut
# pullSlmk && PullLtoSlmk
# TypeBuildTag="[NON-CFW][PRIVATE-LTO-SLMK]"
# CompileClangLTOKernel && CleanOut
# CompileGccKernel

# KernelBranch="20210205/neutrino-3-gcc"
# CloneKernel "--depth=1"
# TypeBuildTag="[NON-CFW][Stock-LMK]"
# CompileGccKernel && CleanOut

# ------ --------
CloneGugelClang
CloneGCCOld
CompileClangKernel && CleanOut
TypeBuildTag="[R][TEST-WIFI]"

# cleanup stuff after done
cd "${MainPath}"
rm -rf *