#! /bin/bash
KernelBranch="r-oss-base"

IncludeFiles "${MainPath}/device/begonia-r-oss.sh"
CustomUploader="Y"
# UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
# spectrumFile="None"
FolderUp="begonia"
TypeBuildTag="[R-OSS][806Mhz][Stable]"

CloneKernel
CloneCompiledGccTwelve
# CloneThirteenGugelClang
# CloneGCCOld
# CloneOldDTCClang
# PullLtoSlmk
# CompileClangKernel && CleanOut
CloneProtonClang
CompileClangKernel && CleanOut
CloneDTCClang
# PullSlmk
CompileClangKernel && CleanOut
CompileGccKernel && CleanOut
# CompileGccKernel

# cleanup stuff after done
cd "${MainPath}"
rm -rf *