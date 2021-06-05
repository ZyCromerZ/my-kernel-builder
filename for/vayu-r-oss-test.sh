#! /bin/bash
KernelBranch="20210529/main-mod"

IncludeFiles "${MainPath}/device/vayu-r-oss.sh"
CustomUploader="Y"
DEFFCONFIG="vayu_user_defconfig"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/vayu_kernel"
FolderUp="shared-file"
TypeBuildTag="[TEST]"

# misc
# doOsdnUp=$FolderUp
# doSFUp=$FolderUp
 

CloneKernel "--depth=1"
# CloneGCCOld && CloneGugelClang
# CompileClangKernel && CleanOut
CloneCompiledGccTwelve && CloneDTCClang
CompileClangKernel && CleanOut
# CloneProtonClang
# CompileProtonClangKernel && CleanOut