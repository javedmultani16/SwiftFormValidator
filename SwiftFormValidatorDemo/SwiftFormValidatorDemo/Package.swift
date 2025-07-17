// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SwiftFormValidator",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftFormValidator",
            targets: ["SwiftFormValidator"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftFormValidator",
            path: "Sources/SwiftFormValidator"
        ),
        .testTarget(
            name: "SwiftFormValidatorTests",
            dependencies: ["SwiftFormValidator"],
            path: "Tests/SwiftFormValidatorTests"
        )
    ]
)
