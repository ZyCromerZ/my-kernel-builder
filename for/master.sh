#! /bin/bash
# KernelBranch="20210405/main"
MainPath="$(pwd)"
echo "test upload" > file.txt
git clone https://${GIT_SECRET}@github.com/ZyCromerZ/uploader-kernel-private $MainPath/up
cd $MainPath/up
chmod +x run.sh
. run.sh $MainPath/file.txt "keqing-drive" "TEST Upload"
# IncludeFiles "${MainPath}/device/lancelot-q-oss.sh"
# CustomUploader="Y"
# IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/lancelot_kernels"
# FolderUp="keqing-drive"
# TypeBuildTag="[STOCK]"

# CloneKernel "--depth=1"
# CloneCompiledGccEleven
# CloneGugelClang
# CompileClangKernel

# # cleanup stuff after done
# cd "${MainPath}"
# rm -rf *