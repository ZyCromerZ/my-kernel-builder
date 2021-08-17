#! /bin/bash
KernelBranch="20201110/neutrino-1"

IncludeFiles "${MainPath}/device/begonia-cfw.sh"
CustomUploader="Y"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="begonia-cfw-neutrino"
ExFolder="LX"
TypeBuildTag="[CFW][Stock-LMK]"

# misc
spectrumFile="bego-on-p.rc"
doSFUp=$FolderUp
 

CloneKernel
CloneCompiledGccEleven && CloneDTCClang && PullLto
CompileClangKernel && PullLtoALmk
CompileClangKernel && PullLtoSlmk
CompileClangKernel && CleanOut


# cleanup stuff after done
cd "${MainPath}"
rm -rf *