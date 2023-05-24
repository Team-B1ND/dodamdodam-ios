//
//  AppRouteBulider.swift
//  DodamDodam
//
//  Created by 이민규 on 2023/05/24.
//  Copyright © 2023 B1ND. All rights reserved.
//

import LinkNavigator

struct AppRouterGroup {
    
    var routers: [RouteBuilder] {
        [
            
            //MARK: - SignIn / SignUp RouteBulider
            
            //MARK: - Home RouteBulider
            HomeRouteBuilder()
        ]
    }
}
