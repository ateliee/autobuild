#!/bin/sh

while [ "$CONFIGURATION" = "" ]
do
    echo "Please Input Build Configuration."
    read CONFIGURATION
    if [ "$CONFIGURATION" = "" ]; then
        echo "Not Found Configuration."
    fi
done

##### ここから定義設定 #####
echo "****** START BUILD FOR \"${CONFIGURATION}\" ******"

res=`xcodebuild -version`
echo ${res}

for file in `\find /Applications/Xcode.app/Contents/Developer/Platforms/ -maxdepth 4 -type d -name '*.sdk'`; do
    echo ${file}
    #cat $file >> out
done


#echo `set`
echo SDK_VERSION
exit
#SDK
SDK="iphoneos5.0"

# Xcodeのプロジェクト名
PROJ_FILE_PATH="hoge.xcodeproj"

# ターゲット名
TARGET_NAME="hogeTarget"

#「Build Settings」にある、プロダクト名
PRODUCT_NAME="hogeProduct"

# app出力先ディレクトリ名
OUT_APP_DIR="out_app"

# 出力先ipaディレクトリ名
OUT_IPA_DIR="ipa"

# 出力されるipaファイル名
IPA_FILE_NAME="hogeIpa"

# ライセンス取得時の開発者名
DEVELOPPER_NAME="iPhone Distribution: hoge Developper"

# アプリのプロビジョニングファイルのパス
PROVISIONING_PATH="${HOME}/Library/MobileDevice/Provisioning\ Profiles/hoge.mobileprovision"



# 出力先ipaディレクトリ作成
# -------------------------
if [ ! -d ${OUT_IPA_DIR} ]; then
    mkdir "${OUT_IPA_DIR}"
fi

exit
# クリーン
# -------------------------
xcodebuild clean -project "${PROJ_FILE_PATH}"

# ビルド
# -------------------------
xcodebuild -project "${PROJ_FILE_PATH}" -sdk "${SDK}" -configuration "${CONFIGURATION}" -target "${TARGET_NAME}" install DSTROOT="${OUT_APP_DIR}"

# Create ipa File
# -------------------------
xcrun -sdk "${SDK}" PackageApplication "${PWD}/${OUT_APP_DIR}/Applications/${PRODUCT_NAME}.app" -o "${PWD}/${OUT_IPA_DIR}/${IPA_FILE_NAME}.ipa" -embed "${PROVISIONING_PATH}"


#
#
#
## プロジェクトのファイルパス ※ここは自分用に変更してね
#projPath="/Users/****/****"
#
## はき出し先ファイルパス ※ここは自分用に変更してね
#ipaPath="/Users/****/****"
#
## ターゲット名
#projectName="*******"
#
## imgPath iconの置き換えに使う
#imgPath="${projectName}/Images.xcassets/AppIcon.appiconset/"
#
## BuindleIDのプレフィックス部分
#prefix="com.*****"
#
## プレフィックスより後ろのBundleIDの定義
#case "$1" in
#    "dev" ) ID="dev.******" ;;
#    "dev01" ) ID="inhouse.******.dev01" ;;
#    "dev02" ) ID="inhouse.******.dev02" ;;
#    "ih-release" ) ID="inhouse.******" ;;
#    "release" ) ID="******" ;;
#    * ) echo "Error: このビルドタイプは設定されていません。"
#        exit 1 ;;
#esac
#echo "BundleID は ${prefix}.${ID} に設定されました。"
#
## Distribution名の定義
#if [ ${1} = "dev" ]; then
#    db="iOS Developer"
#else
#    db="iPhone Distribution: ****** inc."
#fi
#echo "Distribution は ${db} に設定されました。"
#
## アプリ名の定義
#case "$1" in
#    "dev" )  appName="**-dev" ;;
#    "dev01" ) appName="**-dev01" ;;
#    "dev02" ) appName="**-dev02" ;;
#    "ih-release" ) appName="**-r" ;;
#    "release" ) appName="******" ;;
#esac
#echo "アプリ名 は ${appName} に設定されました。"
#
## provioningFileの定義
#case "$1" in
#    "dev" )  pf="Automatic" ;;
#    "dev01" ) pf="********-****-****-****-************" ;;
#    "dev02" ) pf="********-****-****-****-************" ;;
#    "ih-release" ) pf="********-****-****-****-************" ;;
#    "release" ) pf="********-****-****-****-************" ;;
#esac
#echo "プロビジョニングファイル名は ${pf} に設定されました。"
#
## Debug or Release の定義
#case "$1" in
#    "dev" )  mode="Debug" ;;
#    "dev01" ) mode="Debug" ;;
#    "dev02" ) mode="Debug" ;;
#    "ih-release" ) mode="Release" ;;
#    "release" ) mode="Release" ;;
#esac
#echo "ビルドのモードは ${mode} に設定されました。"
#
#echo "バージョンは ${2} に設定されました。"
#
#echo "****** END DEFINE ******"
#
## 一度確認
#echo "ARE YOU READY? この設定で実行してよろしいですか？ [yes/no]"
#read answer
#case "$answer" in
#yes)
#  echo "COOOOOOOOOOOOOOOL!"
#  : OK
#  ;;
#*)
#  echo "OMG! See you again!lol"
#  exit 1
#  ;;
#esac
#
#
###### ここから実行コマンド ######
#
## プロジェクトファイルまで移動
#cd $projPath
#echo "プロジェクトファイルまで移動しました"
#
### plistの変更
## bundleID
#sed -i .bk -e "s/${prefix}.dev.******/${prefix}.${ID}/g" ${projectName}/${projectName}-Info.plist
#echo "BundleIDを変更しました"
#
## icon(ロゴ)の変更
#cp -f "${imgPath}"ico-60@3x_"${1}".png "${imgPath}"ico-60@3x.png
#cp -f "${imgPath}"ico-60@2x_"${1}".png "${imgPath}"ico-60@2x.png
#cp -f "${imgPath}"ico-40@2x_"${1}".png "${imgPath}"ico-40@2x.png
#cp -f "${imgPath}"ico-29@2x_"${1}".png "${imgPath}"ico-29@2x.png
#echo "iconのファイル名を変更しました"
#
## 全部のビルドをクリーンする
#xcodebuild clean -project ${projectName}.xcodeproj
#echo "クリーンビルドしました"
#
## ビルド mode, destribution, target名 を指定
#xcodebuild -sdk iphoneos\
#    -project "${projectName}.xcodeproj/" -target "${projectName}"\
#    -configuration "${mode}" build \
#    CODE_SIGN_IDENTITY="${db}" \
#    PROVISIONING_PROFILE="${pf}"
#echo "ビルドしました"
#
## ipaファイルの保存先フォルダを作る
#mkdir "${ipaPath}"/"${2}"
#
## .appをパッケージして.ipaファイルを作る
#xcrun -sdk iphoneos PackageApplication \
#  build/"${mode}"-iphoneos/"${projectName}".app \
#  -o "${ipaPath}"/"${2}"/"${appName}".ipa
#echo "ipaファイルを作成しました"
#
## plistを元に戻す
#mv -f ${projectName}/${projectName}-Info.plist.bk ${projectName}/${projectName}-Info.plist
## 画像を元に戻す
#cp -f "${imgPath}"ico-60@3x_dev.png "${imgPath}"ico-60@3x.png
#cp -f "${imgPath}"ico-60@2x_dev.png "${imgPath}"ico-60@2x.png
#cp -f "${imgPath}"ico-40@2x_dev.png "${imgPath}"ico-40@2x.png
#cp -f "${imgPath}"ico-29@2x_dev.png "${imgPath}"ico-29@2x.png
#
#echo "ALL FINISH BABY! ENJOY YOUR DEVELOPMENT!! haha"
#
#exit 0