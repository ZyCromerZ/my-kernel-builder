#! /bin/bash
branch="20200907/root-upstream-mod"

IncludeFiles "${MainPath}/device/begonia-cfw.sh"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
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
CloneGccten && CloneGugelClang
CompileClangKernel && CleanOut

KDType='stock-dtc'
CloneOldDTCClang
CompileClangKernel && CleanOut

KDType='stock-gcc'
CompileGccKernel