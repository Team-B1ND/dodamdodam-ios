//
//  SideEffect.swift
//  DodamDodam
//
//  Created by 이민규 on 2023/05/24.
//  Copyright © 2023 B1ND. All rights reserved.
//

import Dependencies
import Foundation
import LinkNavigator

public struct EmptyDependency: DependencyType {
    
}

fileprivate var navigator: LinkNavigatorType = LinkNavigator(
    dependency: EmptyDependency(),
    builders: AppRouterGroup().routers)

public struct AppSideEffect: DependencyKey {
    
    let linkNavigator: LinkNavigatorType
    
    //MARK: - example ( let NAME: NAMESideEffect )
    
    let home: HomeSideEffect
    
    public static var liveValue: AppSideEffect {
        
        return .init(
            linkNavigator: navigator,
            
            //MARK: - example ( NAME: NAMESideEffectLive() )

            home: HomeSideEffectLive(navigator: navigator)
        )
    }
}

extension DependencyValues {
    
    var sideEffect: AppSideEffect {
        
        get { self[AppSideEffect.self] }
        set { self[AppSideEffect.self] = newValue }
    }
}
