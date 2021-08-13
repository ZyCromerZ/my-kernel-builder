#! /bin/bash
KernelBranch="20210812/main-prepare"

IncludeFiles "${MainPath}/device/vayu-r-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/vayu_kernel"
# FolderUp="shared-file"
TypeBuildTag="[TEST][ThinLTO]"

# misc
# doOsdnUp=$FolderUp
# doSFUp=$FolderUp
 

CloneKernel "--depth=1"
# CloneGCCOld && CloneGugelClang
# CompileClangKernel && CleanOut
CloneProtonClang
CompileProtonClangKernel && CleanOut
DEFFCONFIG="vayu_gcc_defconfig"
TypeBuildTag="[TEST][NORMAL]"
# CloneCompiledGccTwelve
CloneCompiledGccEleven
# CloneSdClang
# CompileClangKernel && CleanOut
CompileGccKernel