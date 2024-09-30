import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    targets: [
        .target(
            name: "Repository",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.b1nd.dodam.studentRepository",
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
                .target(name: "Network"),
                .target(name: "Local")
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
                .external(name: "Moya"),
                .external(name: "SignKit"),
                .external(name: "FirebaseMessaging"),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared"))
            ]
        ),
        .target(
            name: "Local",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.b1nd.dodam.studentLocal",
            deploymentTargets: .iOS("15.0"),
            sources: ["Local/Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .external(name: "RealmSwift"),
                .external(name: "Realm"),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared"))
            ]
        )
    ]
)
