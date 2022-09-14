// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "J2objcPackage",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "J2objcPackage",
            targets: ["J2objcPackage", "JRE", "JSON", "ProtobufRuntime"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "J2objcPackage",
            dependencies: [],
            cSettings: [.headerSearchPath("JRE.xcframework/Headers"), .headerSearchPath("JSON.xcframework/Headers"), .headerSearchPath("ProtobufRuntime.xcframework/Headers")]),
        .binaryTarget(name: "JRE", url: "https://u247826.your-storagebox.de/ios/dependencies/j2objc/2.8a/JRE.xcframework.zip", checksum: "5c4cad8f15332dce41199291530b1fee637505fbf61b8cf1f60c4edddfbf118e"),
        .binaryTarget(name: "JSON", url: "https://u247826.your-storagebox.de/ios/dependencies/j2objc/2.8a/JSON.xcframework.zip", checksum: "4c005b5e922d2d5a116060ddd207e522da2202c48388abddf8c82b27cb90f179"),
        .binaryTarget(name: "ProtobufRuntime", url: "https://u247826.your-storagebox.de/ios/dependencies/j2objc/2.8a/ProtobufRuntime.xcframework.zip", checksum: "4d4ae8387c6746e71359abf497c97f0e9c7f5d540eda4ec4ebcaeee6788879e6"),
        .testTarget(
            name: "J2objcPackageTests",
            dependencies: ["J2objcPackage"]),
    ]
)
