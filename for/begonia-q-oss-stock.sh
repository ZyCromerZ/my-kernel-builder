#! /bin/bash
KernelBranch="q-oss-upstream-mod"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="begonia-memeui-Stock"
TypeBuildTag="[NON-CFW]"

# misc
doOsdnUp=$FolderUp
doSFUp=$FolderUp
PostLinkNow="Y"
KernelDownloader="Y"
KDType="stock-memeui-clang"

CloneKernel "--depth=1"
CloneCompiledGccEleven && CloneGugelClang
CompileClangKernel && CleanOut

KDType='stock-memeui-dtc'
CloneOldDTCClang
CompileClangKernel && CleanOut

KDType='stock-memeui-gcc'
CompileGccKernel