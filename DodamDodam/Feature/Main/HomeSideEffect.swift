//
//  HomeSideEffect.swift
//  DodamDodam
//
//  Created by 이민규 on 2023/05/24.
//  Copyright © 2023 B1ND. All rights reserved.
//

import LinkNavigator

public protocol HomeSideEffect {
    
    var onTapButton: () -> Void { get }
}

public struct HomeSideEffectLive {
    
    let navigator: LinkNavigatorType
    
    public init(navigator: LinkNavigatorType) {
        self.navigator = navigator
    }
}

extension HomeSideEffectLive: HomeSideEffect {
    
    public var onTapButton: () -> Void {
        {
            navigator.sheet(paths: [""], items: [:], isAnimated: true)
        }
    }
}
