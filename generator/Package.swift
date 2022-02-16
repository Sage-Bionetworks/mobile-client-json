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
        .package(name: "JsonModel",
                 path: "../../JsonModel-Swift/"),
//                 url: "https://github.com/Sage-Bionetworks/JsonModel-Swift.git",
//                 from: "1.3.4"),
        .package(name: "MotorControl",
                 path: "../../MotorControl-iOS/"),
//                 url: "https://github.com/Sage-Bionetworks/MotorControl-iOS.git",
//                 .revision("90c418ed59e10ee1fe02083e2015c54bc056e2f5")),
 //                from: "4.0.1"),
        .package(name: "SageResearch",
                 path: "../../SageResearch/"),
        .package(name: "MobilePassiveData",
                 path: "../../MobilePassiveData-SDK/"),
    ],
    targets: [
        
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "generator",
            dependencies: [
                .product(name: "MotorControl", package: "MotorControl"),
                .product(name: "JsonModel", package: "JsonModel"),
                .product(name: "Research", package: "SageResearch"),
                .product(name: "MobilePassiveData", package: "MobilePassiveData"),
            ]),
        .testTarget(
            name: "generatorTests",
            dependencies: ["generator"]),
    ]
)
