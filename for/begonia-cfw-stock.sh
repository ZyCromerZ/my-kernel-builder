#! /bin/bash
branch="20200907/root-upstream-mod"

chmod +x ${MainPath}/device/begonia-cfw.sh && . ${MainPath}/device/begonia-cfw.sh
chmod +x ${MainPath}/misc/kernel.sh && . ${MainPath}/misc/kernel.sh "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
CustomUploader="Y"
FolderUp="begonia-cfw-Stock"
TypeBuildTag="[CFW]"

# misc
doOsdnUp=$FolderUp
doSFUp=$FolderUp
PostLinkNow="Y"
KernelDownloader="Y"
KDType="stock-clang"

CloneKernel "--depth=1"
CloneGcc10
CloneGugelClang
CompileClangKernel && CleanOut

KDType='stock-dtc'
CloneOldDTCClang
CompileClangKernel && CleanOut

KDType='stock-gcc'
CompileGccKernel