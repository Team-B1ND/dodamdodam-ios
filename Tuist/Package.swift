// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        baseSettings: .settings(
            base: .init(),
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ],
            defaultSettings: .recommended
        ),
        projectOptions: [
            "LocalSwiftPackage": .options(disableSynthesizedResourceAccessors: false)
        ]
    )

#endif

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/Team-B1ND/dds-ios", exact: "0.1.0"),
        .package(url: "https://github.com/Moya/Moya", from: "15.0.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(url: "https://github.com/Mercen-Lee/FlowKit", branch: "main"),
        .package(url: "https://github.com/Mercen-Lee/SignKit", exact: "0.0.2")
    ]
)
