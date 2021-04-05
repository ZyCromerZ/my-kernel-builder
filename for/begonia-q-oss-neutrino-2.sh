#! /bin/bash
KernelBranch="20210205/neutrino-2"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="begonia-memeui-neutrino"
ExFolder="LY"
TypeBuildTag="[NON-CFW][Stock-LMK]"

# misc
spectrumFile="bego-on-p.rc"
doSFUp=$FolderUp
PostLinkNow="Y"

CloneKernel
CloneCompiledGccEleven && CloneGugelClang
CompileClangKernel && pullALmk
CompileClangKernel && pullSlmk
CompileClangKernel && CleanOut

CloneOldDTCClang
TypeBuildTag="[NON-CFW][Stock-LMK]"
CompileClangKernel && pullALmk
CompileClangKernel && pullSlmk
CompileClangKernel && CleanOut

TypeBuildTag="[NON-CFW][Stock-LMK]"
CompileGccKernel && pullALmk
CompileGccKernel && pullSlmk
CompileGccKernel && CleanOut