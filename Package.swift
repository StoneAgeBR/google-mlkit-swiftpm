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
    .binaryTarget(
      name: "MLKitImageLabelingCommon",
      path: "MLKitFrameworks/MLKitImageLabelingCommon.xcframework.zip"),
      .binaryTarget(
      name: "MLKitVisionKit",
      path: "MLKitFrameworks/MLKitVisionKit.xcframework.zip"),
    .binaryTarget(
      name: "MLImage",
      path: "MLKitFrameworks/MLImage.xcframework.zip"),
    .binaryTarget(
      name: "MLKitObjectDetection",
      path: "MLKitFrameworks/MLKitObjectDetection.xcframework.zip"),
    .binaryTarget(
      name: "MLKitObjectDetectionCommon",
      path: "MLKitFrameworks/MLKitObjectDetectionCommon.xcframework.zip"),
    .binaryTarget(
      name: "MLKitCommon",
      path: "MLKitFrameworks/MLKitCommon.xcframework.zip"),
    .binaryTarget(
      name: "MLKitFaceDetection",
      path: "MLKitFrameworks/MLKitFaceDetection.xcframework.zip"),
    .binaryTarget(
      name: "MLKitVision",
      path: "MLKitFrameworks/MLKitVision.xcframework.zip"),
    .binaryTarget(
      name: "GoogleToolboxForMac",
      path: "MLKitFrameworks/GoogleToolboxForMac.xcframework.zip"),
    .binaryTarget(
      name: "GoogleUtilitiesComponents",
      path: "MLKitFrameworks/GoogleUtilitiesComponents.xcframework.zip"),
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
