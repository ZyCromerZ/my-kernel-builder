#! /bin/bash
KernelBranch="q-oss-upstream"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
# UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
# spectrumFile="bego-on-p.rc"
FolderUp="begonia"
TypeBuildTag="[Q-OSS][Stable]"

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
# CompileGccKernel && CleanOut
CompileGccKernel

# cleanup stuff after done
cd "${MainPath}"
rm -rf *