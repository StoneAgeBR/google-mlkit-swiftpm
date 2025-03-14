// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "google-mlkit-swiftpm",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "MLKitObjectDetection",
      targets: ["MLKitObjectDetection", "MLKitObjectDetectionCommon", "MLImage", "MLKitVision", "MLKitVisionKit", "Common", "MLKitImageLabelingCommon"]),
    .library(
      name: "MLKitFaceDetection",
      targets: ["MLKitFaceDetection", "MLImage", "MLKitVision", "Common"]),
  ],
  dependencies: [
    .package(url: "https://github.com/google/promises.git", exact: "2.4.0"),
    .package(url: "https://github.com/google/GoogleDataTransport.git", exact: "9.4.0"),
    .package(url: "https://github.com/google/GoogleUtilities.git", exact: "7.13.2"),
    .package(url: "https://github.com/google/gtm-session-fetcher.git", exact: "3.4.1"),
    .package(url: "https://github.com/firebase/nanopb.git", exact: "2.30910.0")
  ],
  targets: [
    // **********   For local import   ***********
    // .binaryTarget(
    //   name: "MLKitImageLabelingCommon",
    //   path: "MLKitFrameworks/MLKitImageLabelingCommon.xcframework.zip"),
    // .binaryTarget(
    //   name: "MLKitVisionKit",
    //   path: "MLKitFrameworks/MLKitVisionKit.xcframework.zip"),
    // .binaryTarget(
    //   name: "MLImage",
    //   path: "MLKitFrameworks/MLImage.xcframework.zip"),
    // .binaryTarget(
    //   name: "MLKitObjectDetection",
    //   path: "MLKitFrameworks/MLKitObjectDetection.xcframework.zip"),
    // .binaryTarget(
    //   name: "MLKitObjectDetectionCommon",
    //   path: "MLKitFrameworks/MLKitObjectDetectionCommon.xcframework.zip"),
    // .binaryTarget(
    //   name: "MLKitCommon",
    //   path: "MLKitFrameworks/MLKitCommon.xcframework.zip"),
    // .binaryTarget(
    //   name: "MLKitFaceDetection",
    //   path: "MLKitFrameworks/MLKitFaceDetection.xcframework.zip"),
    // .binaryTarget(
    //   name: "MLKitVision",
    //   path: "MLKitFrameworks/MLKitVision.xcframework.zip"),
    // .binaryTarget(
    //   name: "GoogleToolboxForMac",
    //   path: "MLKitFrameworks/GoogleToolboxForMac.xcframework.zip"),
    // .binaryTarget(
    //   name: "GoogleUtilitiesComponents",
    //   path: "MLKitFrameworks/GoogleUtilitiesComponents.xcframework.zip"),

    .binaryTarget(
      name: "MLKitImageLabelingCommon",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/MLKitImageLabelingCommon.xcframework.zip",
      checksum: "7da6ae30d58690d6d8a9f4c15d83ce9fc9100dca323e8dca0ac50541f53087b2"),
    .binaryTarget(
      name: "MLKitVisionKit",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/MLKitVisionKit.xcframework.zip",
      checksum: "74ccf785302b16c41591c4dfbeabb3eb0fb7d4e89c77e1ed68635cdc0748df62"),
    .binaryTarget(
      name: "MLImage",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/MLImage.xcframework.zip",
      checksum: "491bde0e630ba159432df25addcfd9866e8c36c02f35e92093f12fd9bc0c2489"),
    .binaryTarget(
      name: "MLKitObjectDetection",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/MLKitObjectDetection.xcframework.zip",
      checksum: "33da9d3d96d167bd5a7e85fa2a1b4067ba025950045d7dc611ee50d14e5fd546"),
    .binaryTarget(
      name: "MLKitObjectDetectionCommon",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/MLKitObjectDetectionCommon.xcframework.zip",
      checksum: "fbfd9112147b090d54d230f87953ee74b91363338274a7dba09ff9b2dc653d62"),
    .binaryTarget(
      name: "MLKitCommon",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/MLKitCommon.xcframework.zip",
      checksum: "507bc409f1c38c75fe43e1f74c3a39c14cb500919e658a7eabe4a77845bca883"),
    .binaryTarget(
      name: "MLKitFaceDetection",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/MLKitFaceDetection.xcframework.zip",
      checksum: "d0369bbc39db742012e137c936d78b45290652d09a45edbff915953f7ba12717"),
    .binaryTarget(
      name: "MLKitVision",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/MLKitVision.xcframework.zip",
      checksum: "aa878da175183b8a905775d9483898371d0e0fa24a99eabb3422e111ac8ea299"),
    .binaryTarget(
      name: "GoogleToolboxForMac",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/GoogleToolboxForMac.xcframework.zip",
      checksum: "696572b1436551c6d7a480dbcc651178071798d82749847c1432feb35f0ce5cd"),
    .binaryTarget(
      name: "GoogleUtilitiesComponents",
      url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/5.0.0/GoogleUtilitiesComponents.xcframework.zip",
      checksum: "eadfb9836599bb436f94b83eb3d1ee73f450a9d24e263ce90a6fced85f0ad4f0"),
    .target(
      name: "Common",
      dependencies: [
        "MLKitCommon",
        "GoogleToolboxForMac",
        "GoogleUtilitiesComponents",
        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
        .product(name: "GULEnvironment", package: "GoogleUtilities"),
        .product(name: "GULISASwizzler", package: "GoogleUtilities"),
        .product(name: "GULLogger", package: "GoogleUtilities"),
        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
        .product(name: "GULNSData", package: "GoogleUtilities"),
        .product(name: "GULNetwork", package: "GoogleUtilities"),
        .product(name: "GULReachability", package: "GoogleUtilities"),
        .product(name: "GULUserDefaults", package: "GoogleUtilities"),
        .product(name: "GTMSessionFetcher", package: "gtm-session-fetcher"),
        .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
        .product(name: "nanopb", package: "nanopb"),
        .product(name: "FBLPromises", package: "promises"),
      ]),
  ]
)
