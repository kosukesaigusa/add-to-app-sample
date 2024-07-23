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

# ディレクトリ
SOURCE_DIR="app"
TARGET_DIR="flutter_module"

# 引数から値を取得する。
ANDROID_ORG=$1
ANDROID_PROJECT_NAME=$2
IOS_ORG=$3
IOS_PROJECT_NAME=$4

ANDROID_PACKAGE="${ANDROID_ORG}.${ANDROID_PROJECT_NAME}"
IOS_BUNDLE_IDENTIFIER="${IOS_ORG}.${IOS_PROJECT_NAME}"

echo "📁 Source directory: $SOURCE_DIR"
echo "📁 Target directory: $TARGET_DIR"
echo "📱 Android package: $ANDROID_PACKAGE"
echo "📱 iOS bundle identifier: $IOS_BUNDLE_IDENTIFIER"
echo "----------------------------------------"

# Android の設定を元にモジュールを作成する。
echo "🛠️  Creating Flutter module..."
rm -rf $TARGET_DIR
flutter create -t module --org $ANDROID_ORG --project-name $ANDROID_PROJECT_NAME $TARGET_DIR

echo "----------------------------------------"

# iOS の設定を更新する。
echo "🍎 Updating iOS configuration..."
find $TARGET_DIR/.ios -type f \( -name "*.plist" -o -name "*.pbxproj" -o -name "*.swift" -o -name "*.h" -o -name "*.m" \) -print0 | xargs -0 sed -i '' "s/${ANDROID_ORG}.${ANDROID_PROJECT_NAME}/${IOS_BUNDLE_IDENTIFIER}/g"

# pubspec.yaml をコピーする。
echo "📄 Copying pubspec.yaml..."
cp $SOURCE_DIR/pubspec.yaml $TARGET_DIR/

# lib ディレクトリの内容をコピーする。
echo "📚 Copying lib directory..."
rm -rf $TARGET_DIR/lib
cp -R $SOURCE_DIR/lib $TARGET_DIR/

# test ディレクトリの内容をコピーする。
echo "🧪 Copying test directory..."
rm -rf $TARGET_DIR/test
if [ -d "$SOURCE_DIR/test" ]; then
  cp -R $SOURCE_DIR/test $TARGET_DIR/
fi

# アセットをコピーする。
echo "🖼️  Copying assets..."
if [ -d "$SOURCE_DIR/assets" ]; then
  cp -R $SOURCE_DIR/assets $TARGET_DIR/
fi

# analysis_options.yaml をコピーする。
echo "📝 Copying analysis_options.yaml..."
if [ -f "$SOURCE_DIR/analysis_options.yaml" ]; then
  cp $SOURCE_DIR/analysis_options.yaml $TARGET_DIR/
fi

# pubspec.yaml を編集する。
echo "✏️  Editing pubspec.yaml..."
sed -i '' 's/^name:.*$/name: flutter_module/' $TARGET_DIR/pubspec.yaml

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
' $TARGET_DIR/pubspec.yaml > $TARGET_DIR/pubspec.yaml.tmp && mv $TARGET_DIR/pubspec.yaml.tmp $TARGET_DIR/pubspec.yaml

echo "----------------------------------------"

cd $TARGET_DIR

# 依存関係をインストールする。
echo "📦 Installing dependencies..."
flutter pub get

echo "----------------------------------------"

# iOS アプリで pod install する前に必要な ios-tools を precache する。
echo "📲 Precaching ios-tools..."
flutter precache --ios

echo "----------------------------------------"
echo "✅ Flutter module has been created successfully!"
echo "👉 Please check the dependencies and adjust as needed."
