#! /bin/bash
KernelBranch="r-oss"

IncludeFiles "${MainPath}/device/merlin-r-oss.sh"
CustomUploader="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
FolderUp="shared-file"
TypeBuildTag="[TEST][R-OSS]"

CloneKernel
CloneCompiledGccEleven 
# CloneDTCClang
CloneProtonClang

CompileClangKernel && CleanOut


# cleanup stuff after done
cd "${MainPath}"
rm -rf *
