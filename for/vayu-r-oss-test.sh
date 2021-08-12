#! /bin/bash
KernelBranch="20210812/main-prepare"

IncludeFiles "${MainPath}/device/vayu-r-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/vayu_kernel"
# FolderUp="shared-file"
TypeBuildTag="[TEST]"

# misc
# doOsdnUp=$FolderUp
# doSFUp=$FolderUp
 

DEFFCONFIG="vayu_defconfig"
CloneKernel "--depth=1"
# CloneGCCOld && CloneGugelClang
# CompileClangKernel && CleanOut
CloneCompiledGccTwelve
# CloneDTCClang
# CompileClangKernel && CleanOut
CloneProtonClang
CompileProtonClangKernel && CleanOut
DEFFCONFIG="vayu_gcc_defconfig"
CompileGccKernel