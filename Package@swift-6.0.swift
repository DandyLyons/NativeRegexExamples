// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NativeRegexExamples",
  platforms: [.iOS(.v16), .macOS(.v13), .macCatalyst(.v16), .tvOS(.v16), .visionOS(.v1), .watchOS(.v9)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "NativeRegexExamples",
      targets: ["NativeRegexExamples"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-custom-dump.git", from: "1.3.3"), // Custom Dump
    .package(url: "https://github.com/marmelroy/PhoneNumberKit.git", from: "4.0.0"), // PhoneNumberKit
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "NativeRegexExamples",
      dependencies: [
        .product(name: "CustomDump", package: "swift-custom-dump"), // CustomDump
        .product(name: "PhoneNumberKit", package: "phonenumberkit"), // also available: PhoneNumberKit-Static, PhoneNumberKit-Dynamic
      ]
    ),
    .testTarget(
      name: "NativeRegexExamplesTests",
      dependencies: [
        "NativeRegexExamples",
        .product(name: "CustomDump", package: "swift-custom-dump"),
      ]
    ),
  ],
  swiftLanguageModes: [.v6, .v5]
)
