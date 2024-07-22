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
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared"))
            ]
        )
    ]
)
