#! /bin/bash 
KernelBranch="20210413/r/main"

IncludeFiles "${MainPath}/device/x01bd.sh"
CustomUploader="Y"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/x01bd_kernel"
FolderUp="xobod-r"
doSFUp=$FolderUp
TypeBuildTag="[R]"
spectrumFile="xobod-base.rc"

CloneKernel "--depth=1"
CloneCompiledGccTwelve
CloneProtonClang
CompileClangKernel && CleanOut
CloneDTCClang
CompileClangKernel && CleanOut
CompileGccKernel && CleanOut

