#! /bin/bash
KernelBranch="20210205/neutrino-1"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="begonia-memeui-neutrino"
ExFolder="LX"
TypeBuildTag="[NON-CFW][Stock-LMK]"

# misc
spectrumFile="bego-on-p.rc"
doSFUp=$FolderUp
 

CloneKernel
CloneCompiledGccEleven
TypeBuildTag="[NON-CFW][Stock-LMK]"
CompileGccKernel && pullALmk
CompileGccKernel && pullSlmk
CompileGccKernel && CleanOut


# cleanup stuff after done
cd "${MainPath}"
rm -rf *