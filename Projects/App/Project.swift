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
                    "CFBundleShortVersionString": "3.0.1",
                    "CFBundleVersion": "1",
                    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen"
                ]
            ),
            sources: ["Source/**"],
            resources: ["Resource/**"],
            scripts: [.swiftLint],
            dependencies: [
                .external(name: "DDS"),
                .external(name: "Moya"),
                .external(name: "Swinject"),
                .external(name: "FlowKit"),
                .external(name: "SignKit"),
                .external(name: "CachedAsyncImage")
            ]
        )
    ]
)
