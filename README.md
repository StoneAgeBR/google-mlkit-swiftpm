# Google MLKit Swift Package Manager Wrapper (Partial Implementation)

## Requirements

- iOS 13 and later
- Xcode 13.2.1 and later

## Installation

### Use Swift Package Manager to install

```swift
    .package(url: "https://github.com/StoneAgeBR/google-mlkit-swiftpm", from: "{{version}}")
```

### Add Linker flags

Add these flags to `Other Linker Flags` in Build Settings of your Xcode projects.

- `-ObjC`
- `-all_load`

Alternatively, add the property `linkerSettings` in the targets that depends from this package, on your project's ``Package.swift``. Like the example below:

```swift
// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "MyPackage",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "MyLib",
      targets: ["MyLib"])
  ],
  dependencies: [
    .package(path: "https://github.com/StoneAgeBR/google-mlkit-swiftpm", from: "5.0.0"),
    .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.0.0")
  ],
  targets: [
    .target(
      name: "MyLib",
      dependencies: [
        .product(name: "MLKitFaceDetection", package: "google-mlkit-swiftpm"),
        .product(name: "MLKitObjectDetection", package: "google-mlkit-swiftpm"),
        .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"),
      ],
      linkerSettings: [
          .unsafeFlags(["-ObjC", "-all_load"])
      ]
    ),
  ]
)
```

### Link `.bundle` to your project

`MLKitFaceDetection` requires `GoogleMVFaceDetectorResources.bundle`, while `MLKitObjectDetection` depends on both `MLKitObjectDetectionResources.bundle` and `MLKitObjectDetectionCommonResources.bundle`. Since the bundles can't be introduced via Swift PM, you need to link to your project by yourself:

- Download `GoogleMVFaceDetectorResources.bundle` from ``https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/{{version}}/GoogleMVFaceDetectorResources.bundle.zip``
- Download `MLKitObjectDetectionResources.bundle` from ``https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/{{version}}/MLKitObjectDetectionResources.bundle.zip``
- Download `MLKitObjectDetectionCommonResources.bundle` from ``https://github.com/StoneAgeBR/google-mlkit-swiftpm/releases/download/{{version}}/MLKitObjectDetectionCommonResources.bundle.zip``
- Add these bundles to your Xcode project and make them available in your build target.

## Limitation

- Since pre-built MLKit binary missing `arm64` for iphonesimulator, this project enables to build in `arm64` for iphoneos and `x86_64` for iphonesimulator only.
- Only supported `Face Detection` and `Object Detection` right now.