#! /bin/bash 
KernelBranch="20210413/r/main"

IncludeFiles "${MainPath}/device/x01bd.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/x01bd_kernel"
FolderUp="keqing-drive"
TypeBuildTag="[R]"

CloneKernel "--depth=1"
CloneGCCOld
CloneGugelClang
CompileClangKernel

