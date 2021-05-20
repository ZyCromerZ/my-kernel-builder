#! /bin/bash
KernelBranch="20210517/neutrino-keqing"

IncludeFiles "${MainPath}/device/vayu-r-oss.sh"
CustomUploader="Y"
DEFFCONFIG="vayu_gcc_defconfig"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/vayu_kernel"
FolderUp="vayu-r-oss"
TypeBuildTag="[R-OSS]"

# misc
# doOsdnUp=$FolderUp
doSFUp=$FolderUp
 

CloneKernel "--depth=1"
CloneCompiledGccTwelve
CompileGccKernel && CleanOut