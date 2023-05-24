//
//  HomeRouteBuilder.swift
//  DodamDodam
//
//  Created by 이민규 on 2023/05/24.
//  Copyright © 2023 B1ND. All rights reserved.
//

import SwiftUI
import LinkNavigator

struct HomeRouteBuilder: RouteBuilder {
    
    var matchPath: String { "home" }
    
    var build: (LinkNavigatorType, [String : String], DependencyType) -> MatchingViewController? {
        { navigator, items, dep in
            WrappingController(matchPath: matchPath) {
                HomeView(store: .init(
                    initialState: Home.State(),
                    reducer: Home()))
                    .navigationBarHidden(true)
            }
        }
    }
}
