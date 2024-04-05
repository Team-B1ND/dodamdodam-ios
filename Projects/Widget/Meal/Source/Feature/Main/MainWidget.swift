//
//  MainWidget.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import SwiftUI
import WidgetKit

struct MainWidget: Widget {
    
    let kind: String = "MealWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MainProvider()) { entry in
            MainView(entry: entry)
        }
        .configurationDisplayName("오늘의 급식")
        .description("오늘의 급식 정보를 간편하게 확인합니다.")
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}
