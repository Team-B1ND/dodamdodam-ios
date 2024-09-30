import Foundation
import ProjectDescription

public extension TargetScript {
    static let swiftLint = TargetScript.pre(
        path: .relativeToRoot("Scripts/SwiftLintRunScript.sh"),
        name: "SwiftLintShell",
        basedOnDependencyAnalysis: false
    )
    static let periphery = TargetScript.pre(
        path: .relativeToRoot("Scripts/PeripheryRunScript.sh"),
        name: "Periphery"
    )
}
