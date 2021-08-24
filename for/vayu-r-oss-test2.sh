#! /bin/bash
KernelBranch="20210824/main"

IncludeFiles "${MainPath}/device/vayu-r-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/vayu_kernel"
# FolderUp="shared-file"
TypeBuildTag="[TEST][Base]"

# misc
# doOsdnUp=$FolderUp
# doSFUp=$FolderUp
 
DEFFCONFIG="vayu_defconfig"
CloneKernel "--depth=1"
CloneGCCOld && CloneGugelClang
CompileClangKernel && CleanOut