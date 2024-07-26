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
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .external(name: "FlowKit")
            ]
        )
    ]
)
