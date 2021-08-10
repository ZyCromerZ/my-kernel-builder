#! /bin/bash
KernelBranch="base"

IncludeFiles "${MainPath}/device/vayu-r-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/vayu_kernel"
# FolderUp="shared-file"
TypeBuildTag="[TEST][BaseSendiri]"

# misc
# doOsdnUp=$FolderUp
# doSFUp=$FolderUp
 
DEFFCONFIG="vayu_defconfig"
CloneKernel "--depth=1"
CloneGCCOld && CloneGugelClang
CompileClangKernel && CleanOut