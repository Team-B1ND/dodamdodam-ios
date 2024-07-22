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
            sources: ["Repository/Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .project(target: "DataSource", path: "")
            ]
        ),
        .target(
            name: "DataSource",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.b1nd.dodam.studentDataSource",
            sources: ["DataSource/Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .project(target: "Network", path: "")
            ]
        ),
        .target(
            name: "Network",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.b1nd.dodam.studentNetwork",
            sources: ["Network/Source/**"],
            dependencies: [
                .external(name: "Moya")
            ]
        )
    ]
)
