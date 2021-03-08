#! /bin/bash
branch="20210205/qk-n"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="begonia-memeui-qk"
ExFolder="N"
TypeBuildTag="[NON-CFW][Stock-LMK]"

# misc
spectrumFile="bego-on.rc"
doOsdnUp=$FolderUp
doSFUp=$FolderUp
PostLinkNow="Y"
KernelDownloader="Y"

CloneKernel "--depth=1"
CloneGccten && CloneGugelClang
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