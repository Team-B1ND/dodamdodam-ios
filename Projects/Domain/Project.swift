import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.b1nd.dodam.studentDomain",
            deploymentTargets: .iOS("15.0"),
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .external(name: "SwiftBok")
            ]
        )
    ]
)
