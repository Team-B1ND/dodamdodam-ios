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
            Group {
                if #available(iOSApplicationExtension 17.0, *) {
                    content(entry: entry)
                        .containerBackground(for: .widget) {
                            Dodam.color(DodamColor.Background.neutral)
                        }
                } else {
                    content(entry: entry)
                }
            }
            .padding(8)
        }
        .configurationDisplayName("급식")
        .description("아침, 점심, 저녁 위젯으로 빠르고 쉽게 확인해요")
        .contentMarginsDisabled()
        .supportedFamilies(widgetFamilyList)
    }
    
    @ViewBuilder
    private func content(entry: MealProvider.Entry) -> some View {
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
                Text("\(Int(entry.meal.calorie.rounded()))Kcal")
                    .label(.medium)
                    .caption1(.medium)
            }
            VStack(alignment: .leading, spacing: 0) {
                ForEach(entry.meal.details, id: \.self) {
                    Text($0.name)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .caption1(.medium)
                        .foreground(DodamColor.Label.normal)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
