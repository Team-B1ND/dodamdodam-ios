//
//  AppMainWidget.swift
//  ProjectDescriptionHelpers
//
//  Created by hhhello0507 on 7/23/24.
//

import Foundation
import WidgetKit
import SwiftUI
import DDS
import DIContainer

@main
struct AppMainWidget: WidgetBundle {
    
    init() {
//        SUIT.register()
        DependencyProvider.shared.register()
    }
    
    var body: some Widget {
        DodamMealWidget()
    }
}
