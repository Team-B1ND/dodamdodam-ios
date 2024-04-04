//
//  IsFirstLoadEnvironment.swift
//  DodamDodam
//
//  Created by Mercen on 4/4/24.
//

import SwiftUI

private struct IsFirstLoadEnvironmentKey: EnvironmentKey {
    
    static var defaultValue: Bool = true
}

extension EnvironmentValues {
    
    var isFirstLoad: Bool {
        get { self [IsFirstLoadEnvironmentKey.self] }
        set {
            self [IsFirstLoadEnvironmentKey.self] = newValue
        }
    }
}
