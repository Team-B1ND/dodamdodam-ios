import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Feature",
    targets: [
        .target(
            name: "Feature",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.b1nd.dodam.studentFeature",
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
            ]
        )
    ]
)
