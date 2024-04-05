import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MealWidget",
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
            name: "DodamDodam-MealWidget",
            destinations: .iOS,
            product: .appExtension,
            bundleId: "com.b1nd.dodam.widget.meal",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleDisplayName": "도담도담",
                    "NSExtension": [
                        "NSExtensionPointIdentifier": "com.apple.widgetkit-extension"
                    ]
                ]
            ),
            sources: ["Source/**"],
            resources: ["Resource/**"],
            scripts: [.swiftLint],
            dependencies: [
                .external(name: "DDS"),
                .external(name: "Moya"),
                .external(name: "Swinject"),
            ]
        )
    ]
)
