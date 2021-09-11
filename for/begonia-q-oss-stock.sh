#! /bin/bash
KernelBranch="q-oss-upstream-mod"

IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
FolderUp="begonia-memeui-Stock"
TypeBuildTag="[Q-OSS]"

# misc
doOsdnUp=$FolderUp
doSFUp=$FolderUp
 
KernelDownloader="Y"
KDType="stock-memeui-clang"

CloneKernel "--depth=1"
CloneCompiledGccEleven && CloneProtonClang
CompileClangKernel && CleanOut

KDType='stock-memeui-dtc'
CloneDTCClang
CompileClangKernel && CleanOut

KDType='stock-memeui-gcc'
CompileGccKernel