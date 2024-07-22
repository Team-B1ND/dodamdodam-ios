import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DodamDodam",
    options: .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    ), 
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
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.b1nd.dodam.student",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleDisplayName": "도담도담",
                    "CFBundleShortVersionString": "3.0.2",
                    "CFBundleVersion": "1",
                    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen"
                ]
            ),
            sources: ["iOS/Source/**"],
            resources: ["iOS/Resource/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Feature", path: .relativeToRoot("Projects/Feature")),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
                .project(target: "Repository", path: .relativeToRoot("Projects/Data")),
                .project(target: "DataSource", path: .relativeToRoot("Projects/Data")),
                .project(target: "Network", path: .relativeToRoot("Projects/Data")),
                .project(target: "DIContainer", path: .relativeToRoot("Projects/DIContainer")),
                .external(name: "DDS")
            ]
        ),
        .target(
            name: "DodamDodamWidget",
            destinations: [.iPhone],
            product: .appExtension,
            bundleId: "com.b1nd.dodam.studentWidget",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["iOS-Widget/Source/**"],
            resources: ["iOS-Widget/Resource/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
                .project(target: "Repository", path: .relativeToRoot("Projects/Data")),
                .project(target: "DataSource", path: .relativeToRoot("Projects/Data")),
                .project(target: "Network", path: .relativeToRoot("Projects/Data")),
                .project(target: "DIContainer", path: .relativeToRoot("Projects/DIContainer")),
                .external(name: "DDS")
            ]
        )
    ]
)
