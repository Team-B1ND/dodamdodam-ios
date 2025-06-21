import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: [.iPhone, .appleWatch],
            product: .framework,
            bundleId: "com.b1nd.dodam.studentDomain",
            deploymentTargets: .multiplatform(
                iOS: "15.0",
                watchOS: "8.0"
            ),
            sources: ["Source/**"],
            scripts: [.swiftLint],
            dependencies: []
        )
    ]
)
