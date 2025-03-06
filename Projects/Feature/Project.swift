import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Feature",
    targets: [
        .target(
            name: "Feature",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.b1nd.dodam.studentFeature",
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .project(target: "DIContainer", path: .relativeToRoot("Projects/DIContainer")),
                .external(name: "CachedAsyncImage"),
                .external(name: "SwiftUIIntrospect"),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
                .external(name: "MarkdownUI")
            ]
        )
    ]
)
