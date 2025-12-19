import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DodamDodam",
    options: .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
    ),
    settings: .settings(
        base: .init()
            .otherLinkerFlags(["$(inherited) -ObjC"]),
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
                    "CFBundleShortVersionString": "3.4.7",
                    "CFBundleVersion": "1",
                    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                    "UIMainStoryboardFile": "",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "FirebaseAppDelegateProxyEnabled": .boolean(false),
                    "UIBackgroundModes": [
                        "remote-notification",
                        "fetch"
                    ],
                    "UIFileSharingEnabled": .boolean(true),
                    "LSSupportsOpeningDocumentsInPlace": .boolean(true),
                    "NSDocumentsFolderUsageDescription": "도담도담에서 파일을 저장하려면 '파일'에 접근해야 합니다.",
                    "NSPhotoLibraryUsageDescription": "도담도담에서 이미지를 저장하려면 '사진'에 접근해야 합니다."
                ]
            ),
            sources: ["iOS/Source/**"],
            resources: ["iOS/Resource/**"],
            entitlements: .file(path: "iOS/Resource/DodamDodam.entitlements"),
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Feature", path: .relativeToRoot("Projects/Feature")),
                .project(target: "Repository", path: .relativeToRoot("Projects/Data")),
                .project(target: "DIContainer", path: .relativeToRoot("Projects/DIContainer")),
                .external(name: "FirebaseMessaging"),
                .target(name: "DodamDodamWidget")
            ]
        ),
        .target(
            name: "DodamDodamWidget",
            destinations: [.iPhone],
            product: .appExtension,
            bundleId: "com.b1nd.dodam.student.widget",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "$(PRODUCT_NAME)",
                "NSExtension": [
                    "NSExtensionPointIdentifier": "com.apple.widgetkit-extension"
                ]
            ]),
            sources: ["iOS-Widget/Source/**"],
            resources: ["iOS-Widget/Resource/**"],
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
                .project(target: "Repository", path: .relativeToRoot("Projects/Data")),
                .project(target: "DIContainer", path: .relativeToRoot("Projects/DIContainer")),
                .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
                .external(name: "DDS")
            ]
        ),
        .target(
            name: "Aggregate",
            destinations: [.iPhone],
            product: .bundle,
            bundleId: "com.b1nd.dodam.aggregate",
            scripts: [.periphery]
        )
    ]
)
