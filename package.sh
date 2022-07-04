  #!/bin/bash
#只需要在终端中输入 $ sh archive.sh  即可打包成ipa
 
packaging(){

#***********配置项目
#工程名称(Project的名字)
RCProjectName=$1
#scheme名字 -可以点击Product->Scheme->Manager Schemes...查看
RCScheme=$2
#Release还是Debug
RCConfiguration="Release"
#日期
#RCDate=`date +%Y%m%d_%H%M`
#工程路径
RCWorkspace=$3
#build路径
RCBuildDir=$4
#plist文件名，默认放在工程文件路径的位置
RCPlistName=$5

#创建构建和输出的路径
mkdir -p $RCBuildDir

#pod 相关配置

#更新pod配置
pod install

#构建
xcodebuild archive \
-workspace "$RCProjectName.xcworkspace" \
-scheme "$RCScheme" \
-destination generic/platform=iOS \
-configuration "$RCConfiguration" \
-archivePath "$RCBuildDir/$RCProjectName" \
clean \
build \
-derivedDataPath "$RCBuildDir"

#生成ipa
xcodebuild -exportArchive \
-archivePath "$RCBuildDir/$RCProjectName.xcarchive" \
-exportPath "$RCBuildDir/IPA" \
-exportOptionsPlist "$RCWorkspace/$RCPlistName"

# open $RCBuildDir

}

#函数调用
# $1 工程名  $2 scheme名字  $3 Release还是Debug  $4 工程路径  $5 ipa文件输出路径 $6 plist文件名字
packaging "IMLib" "IMLib" "./" "./build" "./ExportOptions.plist"


