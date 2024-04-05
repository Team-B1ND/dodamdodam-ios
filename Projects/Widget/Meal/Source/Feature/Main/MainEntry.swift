//
//  MainEntry.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import WidgetKit

struct MainEntry: TimelineEntry {
    let date: Date
    let meal: [MealTime: String]
}
