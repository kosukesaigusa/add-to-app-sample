#!/bin/bash

# 引数の数をチェックする。
if [ "$#" -ne 4 ]; then
    echo "❌ Error: Incorrect number of arguments"
    echo "Usage: $0 <android_org> <android_project_name> <ios_org> <iOSProjectName>"
    echo "Example: $0 com.example android_project_name com.example iOSProjectName"
    exit 1
fi

# Flutterのバージョンを表示する。
echo "----------------------------------------"
echo "🚀 Creating Flutter module with the following Flutter version:"
flutter --version
echo "----------------------------------------"

# 引数から値を取得する。
ANDROID_ORG=$1
ANDROID_PROJECT_NAME=$2
IOS_ORG=$3
IOS_PROJECT_NAME=$4

ANDROID_PACKAGE="${ANDROID_ORG}.${ANDROID_PROJECT_NAME}"
IOS_BUNDLE_IDENTIFIER="${IOS_ORG}.${IOS_PROJECT_NAME}"

echo "📁 Source directory: flutter/packages"
echo "📁 Flutter app directory name: app"
echo "📁 Target directory: flutter_module"
echo "📱 Android package: $ANDROID_PACKAGE"
echo "📱 iOS bundle identifier: $IOS_BUNDLE_IDENTIFIER"
echo "----------------------------------------"

# ディレクトリ全体をコピーする
echo "📂 Copying entire directory structure..."
rm -rf flutter_module
mkdir -p flutter_module/packages
cp -R flutter/packages/* flutter_module/packages/

# Android の設定を元にモジュールの本体 (app) を作成する。
echo "🛠️  Creating Flutter module..."
rm -rf flutter_module/packages/app
flutter create -t module --org $ANDROID_ORG --project-name $ANDROID_PROJECT_NAME flutter_module/packages/app

echo "----------------------------------------"

# iOS の設定を更新する。
echo "🍎 Updating iOS configuration..."
find flutter_module/packages/app/.ios -type f \( -name "*.plist" -o -name "*.pbxproj" -o -name "*.swift" -o -name "*.h" -o -name "*.m" \) -print0 | xargs -0 sed -i '' "s/${ANDROID_ORG}.${ANDROID_PROJECT_NAME}/${IOS_BUNDLE_IDENTIFIER}/g"

# pubspec.yaml をコピーする。
echo "📄 Copying pubspec.yaml..."
cp flutter/packages/app/pubspec.yaml flutter_module/packages/app/

# lib ディレクトリの内容をコピーする。
echo "📚 Copying lib directory..."
rm -rf flutter_module/packages/app/lib
cp -R flutter/packages/app/lib flutter_module/packages/app/

# test ディレクトリの内容をコピーする。
echo "🧪 Copying test directory..."
rm -rf flutter_module/packages/app/test
if [ -d "flutter/packages/app/test" ]; then
  cp -R flutter/packages/app/test flutter_module/packages/app/
fi

# アセットをコピーする。
echo "🖼️  Copying assets..."
if [ -d "flutter/packages/app/assets" ]; then
  cp -R flutter/packages/app/assets flutter_module/packages/app/
fi

# analysis_options.yaml をコピーする。
echo "📝 Copying analysis_options.yaml..."
if [ -f "flutter/packages/app/analysis_options.yaml" ]; then
  cp flutter/packages/app/analysis_options.yaml flutter_module/packages/app/
fi

# pubspec.yaml を編集する。
echo "✏️  Editing pubspec.yaml..."
sed -i '' 's/^name:.*$/name: flutter_module/' flutter_module/packages/app/pubspec.yaml

# モジュール設定を追加する。
echo "⚙️  Adding module settings to pubspec.yaml..."
awk '
  /^flutter:/ { 
    print
    print "  module:"
    print "    androidX: true"
    print "    androidPackage: '"$ANDROID_PACKAGE"'"
    print "    iosBundleIdentifier: '"$IOS_BUNDLE_IDENTIFIER"'"
    next
  }
  { print }
' flutter_module/packages/app/pubspec.yaml > flutter_module/packages/app/pubspec.yaml.tmp && mv flutter_module/packages/app/pubspec.yaml.tmp flutter_module/packages/app/pubspec.yaml

echo "----------------------------------------"

# Melos による依存関係のインストールとコード生成を行う。
echo "🔄 Installing dependencies and generating code..."
melos bs
melos run build

echo "----------------------------------------"

# iOS アプリで pod install する前に必要な ios-tools を precache する。
echo "📲 Precaching ios-tools..."
cd flutter_module/packages/app
flutter precache --ios

echo "----------------------------------------"
echo "✅ Flutter module has been created successfully!"
echo "👉 Please check the dependencies and adjust as needed."
