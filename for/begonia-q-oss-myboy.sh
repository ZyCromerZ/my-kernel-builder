#! /bin/bash
KernelBranch="20210205/neutrino-3-custom"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="keqing-drive"
TypeBuildTag="[NON-CFW][PRIVATE][SLMK][Thin-LTO]"
# TypeBuildTag="[NON-CFW][Stock-LMK]"

CloneKernel "--depth=1"
CloneCompiledGccEleven
CloneGugelClang
CompileClangKernel && CleanOut

# cleanup stuff after done
cd "${MainPath}"
rm -rf *