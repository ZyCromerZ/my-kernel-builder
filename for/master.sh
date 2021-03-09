#! /bin/bash
# KernelBranch="20210205/neutrino-3"

# IncludeFiles "${MainPath}/device/begonia-q-oss.sh"
# CustomUploader="Y"
# IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
# FolderUp="keqing-drive"
# TypeBuildTag="[NON-CFW][TEST]"

# CloneKernel
# CloneGccten
# CompileGccKernel && CleanOut
# CloneGugelClang
# pullSlmk && PullLtoSlmk
# TypeBuildTag="[NON-CFW][PRIVATE-LTO-SLMK]"
# CompileClangLTOKernel && CleanOut

# CloneOldDTCClang
# pullSlmk && PullLtoSlmk
# TypeBuildTag="[NON-CFW][PRIVATE-LTO-SLMK]"
# CompileClangLTOKernel && CleanOut
