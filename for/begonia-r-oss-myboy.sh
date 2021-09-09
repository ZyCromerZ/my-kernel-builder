#! /bin/bash
KernelBranch="r-oss"

IncludeFiles "${MainPath}/device/begonia-r-oss.sh"
CustomUploader="Y"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
spectrumFile="bego-on-p.rc"
FolderUp="shared-file"
TypeBuildTag="[R-OSS]"

CloneKernel "--depth=1"
# CloneCompiledGccEleven
CloneCompiledGccEleven
# CloneElevenGugelClang
CloneDTCClang
# CompileClangKernel && CleanOut
# CloneElevenGugelClang
CompileClangKernel && CleanOut
# PullSlmk
# CompileGccKernel && CleanOut

# cleanup stuff after done
cd "${MainPath}"
rm -rf *