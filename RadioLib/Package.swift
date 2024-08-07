// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RadioLib",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RadioLib",
            targets: ["RadioLib"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        //.package(url: "https://github.com/scinfu/SwiftSoup", from: "2.3.2"),
        //.package(url: "https://github.com/shvets/SimpleHttpClient", from: "1.0.9"),
//        .package(name: "SimpleHttpClient", path: "../../YagaTiVi-base/SimpleHttpClient"),
        .package(url: "https://github.com/shvets/DiskStorage", from: "1.0.2"),
        //.package(name: "DiskStorage", path: "../../YagaTiVi-base/DiskStorage"),
        .package(url: "https://github.com/shvets/media-player", from: "1.0.0"),
        .package(url: "https://github.com/shvets/Swiper", from: "1.0.0"),
        .package(name: "site-builder", path: "../../YagaTiVi/site-builder")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RadioLib",
            dependencies: [
             //"SwiftSoup",
              //"SimpleHttpClient",
              "DiskStorage",
              "media-player",
              .product(name: "swiper", package: "Swiper"),
              "site-builder"
            ]),
        .testTarget(
            name: "RadioLibTests",
            dependencies: ["RadioLib"]),
    ]
)
