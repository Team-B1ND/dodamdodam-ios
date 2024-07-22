//
//  DodamMealWidget.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/23/24.
//

import SwiftUI
import WidgetKit
import Shared
import DDS
import Domain

struct DodamMealWidget: Widget {
    
    @Environment(\.widgetFamily) private var widgetFamily
    
    private let widgetFamilyList: [WidgetFamily] = if #available(iOSApplicationExtension 16.0, *) {
        [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryCircular]
    } else {
        [.systemSmall, .systemMedium]
    }
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "DodamMealWidget",
            provider: MealProvider()
        ) { entry in
            SmallDodamMealWidget(entry: entry)
        }
        .configurationDisplayName("급식")
        .description("아침, 점심, 저녁 위젯으로 빠르고 쉽게 확인해요")
        .contentMarginsDisabled()
        .supportedFamilies(widgetFamilyList)
    }
}

struct SmallDodamMealWidget: View {
    
    private let entry: MealProvider.Entry
    
    init(entry: MealProvider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        Group {
            if #available(iOSApplicationExtension 17.0, *) {
                content(meal: entry.meal.lunch)
                    .containerBackground(for: .widget) {
                        Dodam.color(DodamColor.Background.neutral)
                    }
            } else {
                content(meal: entry.meal.lunch)
            }
        }
        .padding(8)
    }
    
    @ViewBuilder
    private func content(meal: Meal?) -> some View {
        VStack(spacing: 4) {
            HStack {
                Text("아침")
                    .foreground(DodamColor.Static.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(DodamColor.Primary.normal)
                    .clipShape(.large)
                    .label(.medium)
                Spacer()
                if let meal {
                    Text("\(Int(meal.calorie.rounded()))Kcal")
                        .label(.medium)
                        .caption1(.medium)
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                if let meal {
                    ForEach(meal.details, id: \.self) {
                        Text($0.name)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .caption1(.medium)
                            .foreground(DodamColor.Label.normal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                } else {
                    Text("급식이 없어요")
                        .caption1(.medium)
                        .foreground(DodamColor.Label.normal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            .padding(8)
            .frame(maxHeight: .infinity)
            .background(DodamColor.Background.normal)
            .clipShape(.large)
        }
        .background(DodamColor.Background.neutral)
    }
}

#Preview {
    SmallDodamMealWidget(entry: .empty)
}
