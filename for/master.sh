#! /bin/bash
branch="20210205/neutrino-3"

. ${MainPath}/device/begonia-q-oss.sh
. ${MainPath}/misc/kernel.sh "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/begonia_kernel"
CustomUploader="Y"
SpectrumPath="Y"
FolderUp="keqing-drive"

CloneKernel "--depth=1"
CloneGcc10
# CloneGugelClang
# CompileClangKernel
CompileGccKernel

