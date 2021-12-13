// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "generator",
    platforms: [
        .macOS(.v11),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // Dependencies declare other packages that this package depends on.
        .package(name: "SageResearch",
                 url: "https://github.com/Sage-Bionetworks/SageResearch.git",
                 from: "4.1.0"),
        .package(name: "JsonModel",
                 url: "https://github.com/Sage-Bionetworks/JsonModel-Swift.git",
                 from: "1.2.0"),
        .package(name: "MobilePassiveData",
                 url: "https://github.com/Sage-Bionetworks/MobilePassiveData-SDK.git",
                 from: "1.0.0"),
    ],
    targets: [
        
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "generator",
            dependencies: [
                .product(name: "Research", package: "SageResearch"),
                .product(name: "AudioRecorder", package: "MobilePassiveData"),
                .product(name: "MotionSensor", package: "MobilePassiveData"),
            ]),
        .testTarget(
            name: "generatorTests",
            dependencies: ["generator"]),
    ]
)
