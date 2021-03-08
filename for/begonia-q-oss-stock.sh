#! /bin/bash
branch="q-oss-upstream-mod"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
CustomUploader="Y"
FolderUp="begonia-memeui-Stock"
TypeBuildTag="[NON-CFW]"

# misc
doOsdnUp=$FolderUp
doSFUp=$FolderUp
PostLinkNow="Y"
KernelDownloader="Y"
KDType="stock-memeui-clang"

CloneKernel "--depth=1"
CloneGccten && CloneGugelClang
CompileClangKernel && CleanOut

KDType='stock-memeui-dtc'
CloneOldDTCClang
CompileClangKernel && CleanOut

KDType='stock-memeui-gcc'
CompileGccKernel