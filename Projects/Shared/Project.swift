import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Shared",
    targets: [
        .target(
            name: "Shared",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.b1nd.dodam.studentShared",
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .external(name: "DDS"),
                .external(name: "Moya"),
                .external(name: "Swinject"),
                .external(name: "FlowKit"),
                .external(name: "SignKit"),
                .external(name: "CachedAsyncImage")
            ]
        )
    ]
)
