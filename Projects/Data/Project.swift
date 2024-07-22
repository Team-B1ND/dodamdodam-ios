import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    targets: [
        .target(
            name: "Repository",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.b1nd.dodam.studentDataSource",
            deploymentTargets: .iOS("15.0"),
            sources: ["Repository/Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .target(name: "DataSource")
            ]
        ),
        .target(
            name: "DataSource",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.b1nd.dodam.studentDataSource",
            deploymentTargets: .iOS("15.0"),
            sources: ["DataSource/Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .target(name: "Network")
            ]
        ),
        .target(
            name: "Network",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.b1nd.dodam.studentNetwork",
            deploymentTargets: .iOS("15.0"),
            sources: ["Network/Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .external(name: "Moya")
            ]
        )
    ]
)
