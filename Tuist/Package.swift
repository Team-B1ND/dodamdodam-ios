// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        baseSettings: .settings(
            base: [
                "IPHONEOS_DEPLOYMENT_TARGET": "15.0"
            ],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ],
            defaultSettings: .recommended
        ),
        targetSettings: [
            "SwiftUIIntrospect": [
                "IPHONEOS_DEPLOYMENT_TARGET": "15.0"
            ]
        ],
        projectOptions: [
            "LocalSwiftPackage": .options(disableSynthesizedResourceAccessors: false)
        ]
    )

#endif

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/Team-B1ND/dds-ios", exact: "0.2.41"),
        .package(url: "https://github.com/Moya/Moya", from: "15.0.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(url: "https://github.com/Mercen-Lee/FlowKit", branch: "main"),
        .package(url: "https://github.com/Mercen-Lee/SignKit", exact: "0.0.2"),
        .package(url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image", exact: "2.1.1"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0"),
        .package(url: "https://github.com/realm/realm-swift", exact: "20.0.0"),
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", from: "1.3.0"),
        .package(url: "https://github.com/gonzalezreal/swift-markdown-ui", exact: "2.4.1")
    ]
)
