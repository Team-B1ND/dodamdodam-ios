import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    targets: [
        .target(
            name: "Data",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.b1nd.dodam.studentData",
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
            ]
        )
    ]
)
