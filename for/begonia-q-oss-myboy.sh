#! /bin/bash
KernelBranch="20210205/neutrino-2"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
spectrumFile="bego-on-p.rc"
FolderUp="shared-file"
TypeBuildTag="[NON-CFW][Stock-LMK]"

CloneKernel
# CloneCompiledGccEleven
CloneCompiledGccEleven
CloneProtonClang
# CloneDTCClang
PullLtoSlmk
# CompileClangKernel && CleanOut
# CloneProtonClang
CompileClangKernel && CleanOut
# PullSlmk
# CompileGccKernel && CleanOut

# cleanup stuff after done
cd "${MainPath}"
rm -rf *