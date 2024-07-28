import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DIContainer",
    targets: [
        .target(
            name: "DIContainer",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.b1nd.dodam.studentDIContainer",
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .external(name: "Swinject")
            ]
        )
    ]
)
