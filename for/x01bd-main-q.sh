#! /bin/bash
branch="20210304/q/main"

chmod +x  ${MainPath}/device/begonia-q-oss.sh && . ${MainPath}/device/begonia-q-oss.sh
chmod +x ${MainPath}/misc/kernel.sh && . ${MainPath}/misc/kernel.sh "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/x01bd_kernel"
CustomUploader="Y"
FolderUp="keqing-drive"
TypeBuildTag="[Q]"

CloneKernel "--depth=1"
CloneGCCOld
CloneGugelClang
CompileClangKernel

