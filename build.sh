PROJECT_ROOT_FOLDER=$(pwd)
PODS_ROOT_FOLDER="$PROJECT_ROOT_FOLDER/Pods"
PODS_PROJECT="$PODS_ROOT_FOLDER/Pods.xcodeproj"
SYMROOT="$PODS_ROOT_FOLDER/Build"
BUILD_FOLDER="$PROJECT_ROOT_FOLDER/MLKitFrameworks"
RESOURCES_FOLDER="$PROJECT_ROOT_FOLDER/Resources"
MAKER_ROOT_FOLDER="$PROJECT_ROOT_FOLDER/xcframework-maker"
MAKER_EXEC="$MAKER_ROOT_FOLDER/.build/release/make-xcframework"




bootstrapCocoapods()
{
    bundle install
	bundle exec pod install
}

bootstrapBuilder()
{
    cd $MAKER_ROOT_FOLDER -maker
    swift build -c release
    cd $PROJECT_ROOT_FOLDER
}

buildCocoapods()
{
    xcodebuild -project "$PODS_PROJECT" \
        -sdk iphoneos \
        -configuration Release -alltargets \
        ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=NO SYMROOT="$SYMROOT" \
        CLANG_ENABLE_MODULE_DEBUGGING=NO \
        IPHONEOS_DEPLOYMENT_TARGET="$IPHONEOS_DEPLOYMENT_TARGET"
    
    xcodebuild -project "$PODS_PROJECT" \
        -sdk iphonesimulator \
        -configuration Release -alltargets \
        ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=NO SYMROOT="$SYMROOT" \
        CLANG_ENABLE_MODULE_DEBUGGING=NO \
        IPHONEOS_DEPLOYMENT_TARGET="$IPHONEOS_DEPLOYMENT_TARGET"
}

prepareInfoPlist()
{
    cp -rf "$RESOURCES_FOLDER/MLKitCommon-Info.plist"                   "$PODS_ROOT_FOLDER/MLKitCommon/Frameworks/MLKitCommon.framework/Info.plist"
	cp -rf "$RESOURCES_FOLDER/MLKitFaceDetection-Info.plist"            "$PODS_ROOT_FOLDER/MLKitFaceDetection/Frameworks/MLKitFaceDetection.framework/Info.plist"
    cp -rf "$RESOURCES_FOLDER/MLKitVision-Info.plist"                   "$PODS_ROOT_FOLDER/MLKitVision/Frameworks/MLKitVision.framework/Info.plist"
	cp -rf "$RESOURCES_FOLDER/MLKitVisionKit-Info.plist"                "$PODS_ROOT_FOLDER/MLKitVisionKit/Frameworks/MLKitVisionKit.framework/Info.plist"
	cp -rf "$RESOURCES_FOLDER/MLImage-Info.plist"                       "$PODS_ROOT_FOLDER/MLImage/Frameworks/MLImage.framework/Info.plist"
	cp -rf "$RESOURCES_FOLDER/MLKitObjectDetection-Info.plist"          "$PODS_ROOT_FOLDER/MLKitObjectDetection/Frameworks/MLKitObjectDetection.framework/Info.plist"
	cp -rf "$RESOURCES_FOLDER/MLKitObjectDetectionCommon-Info.plist"    "$PODS_ROOT_FOLDER/MLKitObjectDetectionCommon/Frameworks/MLKitObjectDetectionCommon.framework/Info.plist"
	cp -rf "$RESOURCES_FOLDER/MLKitImageLabelingCommon-Info.plist"      "$PODS_ROOT_FOLDER/MLKitImageLabelingCommon/Frameworks/MLKitImageLabelingCommon.framework/Info.plist"
}

createXcframework()
{
    rm -rf $BUILD_FOLDER

	xcodebuild -create-xcframework \
		-framework $PODS_ROOT_FOLDER/Pods/Build/Release-iphonesimulator/GoogleToolboxForMac/GoogleToolboxForMac.framework \
		-framework $PODS_ROOT_FOLDER/Pods/Build/Release-iphoneos/GoogleToolboxForMac/GoogleToolboxForMac.framework \
		-output $BUILD_FOLDER/GoogleToolboxForMac.xcframework
	
    xcodebuild -create-xcframework \
		-framework $PODS_ROOT_FOLDER/Pods/Build/Release-iphonesimulator/GoogleUtilitiesComponents/GoogleUtilitiesComponents.framework \
		-framework $PODS_ROOT_FOLDER/Pods/Build/Release-iphoneos/GoogleUtilitiesComponents/GoogleUtilitiesComponents.framework \
		-output $BUILD_FOLDER/GoogleUtilitiesComponents.xcframework
	
    
    $MAKER_EXEC \
        -ios $PODS_ROOT_FOLDER/MLImage/Frameworks/MLImage.framework \
        -output $BUILD_FOLDER
	$MAKER_EXEC \
        -ios $PODS_ROOT_FOLDER/MLKitCommon/Frameworks/MLKitCommon.framework \
        -output $BUILD_FOLDER
	$MAKER_EXEC \
        -ios $PODS_ROOT_FOLDER/MLKitVision/Frameworks/MLKitVision.framework \
        -output $BUILD_FOLDER
	$MAKER_EXEC \
        -ios $PODS_ROOT_FOLDER/MLKitVisionKit/Frameworks/MLKitVisionKit.framework \
        -output $BUILD_FOLDER
	$MAKER_EXEC \
        -ios $PODS_ROOT_FOLDER/MLKitImageLabelingCommon/Frameworks/MLKitImageLabelingCommon.framework \
        -output $BUILD_FOLDER
	$MAKER_EXEC \
        -ios $PODS_ROOT_FOLDER/MLKitFaceDetection/Frameworks/MLKitFaceDetection.framework \
        -output $BUILD_FOLDER
	$MAKER_EXEC \
        -ios $PODS_ROOT_FOLDER/MLKitObjectDetectionCommon/Frameworks/MLKitObjectDetectionCommon.framework \
        -output $BUILD_FOLDER
	$MAKER_EXEC \
        -ios $PODS_ROOT_FOLDER/MLKitObjectDetection/Frameworks/MLKitObjectDetection.framework \
        -output $BUILD_FOLDER
}

archive()
{
    cd  $BUILD_FOLDER/MLKitFaceDetection.xcframework/ios-arm64/MLKitFaceDetection.framework \
        && mv MLKitFaceDetection MLKitFaceDetection.o \
        && ar r MLKitFaceDetection MLKitFaceDetection.o \
        && ranlib MLKitFaceDetection \
        && rm MLKitFaceDetection.o
	cd  $BUILD_FOLDER/MLKitFaceDetection.xcframework/ios-x86_64-simulator/MLKitFaceDetection.framework \
        && mv MLKitFaceDetection MLKitFaceDetection.o \
        && ar r MLKitFaceDetection MLKitFaceDetection.o \
        && ranlib MLKitFaceDetection \
        && rm MLKitFaceDetection.o

	cd  $BUILD_FOLDER \
        && zip -r MLKitObjectDetection.xcframework.zip MLKitObjectDetection.xcframework \
        && zip -r MLKitFaceDetection.xcframework.zip MLKitFaceDetection.xcframework \
        && zip -r MLKitObjectDetectionCommon.xcframework.zip MLKitObjectDetectionCommon.xcframework \
        && zip -r GoogleToolboxForMac.xcframework.zip GoogleToolboxForMac.xcframework \
        && zip -r GoogleUtilitiesComponents.xcframework.zip GoogleUtilitiesComponents.xcframework \
        && zip -r MLImage.xcframework.zip MLImage.xcframework \
        && zip -r MLKitCommon.xcframework.zip MLKitCommon.xcframework \
        && zip -r MLKitVision.xcframework.zip MLKitVision.xcframework \
        && zip -r MLKitVisionKit.xcframework.zip MLKitVisionKit.xcframework \
        && zip -r MLKitImageLabelingCommon.xcframework.zip MLKitImageLabelingCommon.xcframework
}

runAll()
{
    echo "\n\n********************************************"
    echo "********* Running bootstrapBuilder *********"
    echo "********************************************\n\n"

    bootstrapBuilder


    echo "\n\n********************************************"
    echo "******** Running bootstrapCocoapods ********"
    echo "********************************************\n\n"

    bootstrapCocoapods


    echo "\n\n********************************************"
    echo "********** Running buildCocoapods **********"
    echo "********************************************\n\n"

    buildCocoapods


    echo "\n\n********************************************"
    echo "********* Running prepareInfoPlist *********"
    echo "********************************************\n\n"

    prepareInfoPlist


    echo "\n\n********************************************"
    echo "******** Running createXcframework *********"
    echo "********************************************\n\n"

    createXcframework


    echo "\n\n********************************************"
    echo "************* Running archive **************"
    echo "********************************************\n\n"

    archive
}

runAll