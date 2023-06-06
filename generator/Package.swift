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
        .package(url: "https://github.com/Sage-Bionetworks/AssessmentModelKMM.git",
                 from: "0.11.0"),
        .package(url: "https://github.com/Sage-Bionetworks/JsonModel-Swift.git",
                 from: "2.2.2"),
        .package(url: "https://github.com/Sage-Bionetworks/MotorControl-iOS.git",
                 from: "5.0.0"),
    ],
    targets: [
        
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "generator",
            dependencies: [
                .product(name: "AssessmentModel", package: "AssessmentModelKMM"),
                .product(name: "JsonModel", package: "JsonModel-Swift"),
                .product(name: "MotorControl", package: "MotorControl-iOS"),
            ]),
        .testTarget(
            name: "generatorTests",
            dependencies: ["generator"]),
    ]
)
