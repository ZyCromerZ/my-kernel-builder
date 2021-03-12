#! /bin/bash
# KernelBranch="20210205/neutrino-3-custom"

# IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
# CustomUploader="Y"
# IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
# FolderUp="keqing-drive"
# TypeBuildTag="[NON-CFW][PRIVATE][SLMK][Thin-LTO]"
# # TypeBuildTag="[NON-CFW][Stock-LMK]"

# CloneKernel "--depth=1"
# # CloneGccten
# # CloneCompiledGcc
# CloneCompiledGccEleven
# # CompileGccKernel && CleanOut
# # CloneGugelClang
# # CompileClangKernel && CleanOut
# # pullSlmk && PullLtoSlmk
# # TypeBuildTag="[NON-CFW][PRIVATE-LTO-SLMK]"
# # CompileClangLTOKernel && CleanOut
# CompileGccKernel

# # KernelBranch="20210205/neutrino-3-gcc"
# # CloneKernel "--depth=1"
# # TypeBuildTag="[NON-CFW][Stock-LMK]"
# # CompileGccKernel && CleanOut

# # cleanup stuff after done
# cd "${MainPath}"
# rm -rf *