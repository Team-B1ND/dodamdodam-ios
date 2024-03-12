import Foundation
import ProjectDescription

public extension TargetScript {
    static let swiftLint = TargetScript.pre(
        path: .relativeToRoot("Scripts/SwiftLintRunScript.sh"),
        name: "SwiftLintShell"
    )
}
