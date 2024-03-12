import ProjectDescription
import ProjectDescriptionHelpers

let schemes: [Scheme] = [
    .scheme(
        name: "DodamDodam-DEBUG",
        shared: true,
        buildAction: .buildAction(targets: ["DodamDodam"]),
        runAction: .runAction(configuration: .debug),
        archiveAction: .archiveAction(configuration: .debug),
        profileAction: .profileAction(configuration: .debug),
        analyzeAction: .analyzeAction(configuration: .debug)
    ),
    .scheme(
        name: "DodamDodam-RELEASE",
        shared: true,
        buildAction: .buildAction(targets: ["DodamDodam"]),
        testAction: nil,
        runAction: .runAction(configuration: .release),
        archiveAction: .archiveAction(configuration: .release),
        profileAction: .profileAction(configuration: .release),
        analyzeAction: .analyzeAction(configuration: .release)
    )
]

let project = Project(
    name: "DodamDodam",
    settings: .settings(
        base: .init(),
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ],
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "DodamDodam",
            destinations: .iOS,
            product: .app,
            bundleId: "com.b1nd.dodam",
            infoPlist: .extendingDefault(
                with: [
                    "NSAllowsArbitraryLoads": true,
                ]
            ),
            sources: ["Source/**"],
            resources: ["Resource/**"],
            scripts: [.swiftLint],
            dependencies: [
                .external(name: "Alamofire"),
            ]
        )
    ],
    schemes: schemes
)
