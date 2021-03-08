#! /bin/bash
branch="20210304/q/main"

IncludeFiles "${MainPath}/device/x01bd.sh"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/x01bd_kernel"
CustomUploader="Y"
FolderUp="keqing-drive"
TypeBuildTag="[Q]"

CloneKernel "--depth=1"
CloneGCCOld
CloneGugelClang
CompileClangKernel

