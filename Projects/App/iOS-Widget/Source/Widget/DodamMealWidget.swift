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
            MealWidgetContent(entry: entry)
        }
        .configurationDisplayName("급식")
        .description("아침, 점심, 저녁 위젯으로 빠르고 쉽게 확인해요")
        .contentMarginsDisabled()
        .supportedFamilies(widgetFamilyList)
    }
}

struct MealWidgetContent: View {
    
    @Environment(\.widgetFamily) private var widgetFamily
    
    private let entry: MealProvider.Entry
    
    init(entry: MealProvider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        Group {
            if #available(iOSApplicationExtension 17.0, *) {
                content(meal: entry.meal)
                    .containerBackground(for: .widget) {
                        Dodam.color(DodamColor.Background.neutral)
                    }
            } else {
                content(meal: entry.meal)
            }
        }
        .padding(8)
    }
    
    @ViewBuilder
    private func content(meal: MealModel?) -> some View {
        let mealType = MealType.from(.now) ?? .breakfast
        let meal = meal?.getMeal(type: mealType)
        VStack(spacing: 4) {
            HStack {
                Text(mealType.label)
                    .foreground(DodamColor.Static.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(DodamColor.Primary.normal)
                    .clipShape(.large)
                    .font(.footnote)
                Spacer()
                if let meal {
                    Text("\(Int(meal.calorie.rounded()))Kcal")
                        .font(.caption)
                        .foreground(DodamColor.Label.alternative)
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                if let meal {
                    if meal.details.isEmpty {
                        Text("오늘은\n급식이 없어요")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foreground(DodamColor.Label.normal)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        if (widgetFamily == .systemSmall) {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(0..<(meal.details.count > 6 ? 6 : meal.details.count), id: \.self) { idx in
                                    Text((meal.details.count > 6 && idx == 6) ? "..." : meal.details[idx].name)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .font(.caption)
                                        .foreground(DodamColor.Label.normal)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .padding(8)
                            .frame(maxHeight: .infinity)
                            .background(DodamColor.Background.normal)
                            .clipShape(.large)
                        } else {
                            HStack {
                                let cutArray = cutArray(array: meal.details)
                                ForEach(cutArray, id: \.self) { meals in
                                    VStack(alignment: .leading, spacing: 0) {
                                        ForEach(meals, id: \.self) { meal in
                                            Text(meal.name)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .font(.caption)
                                                .foreground(DodamColor.Label.normal)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                            }
                            .padding(8)
                            .frame(maxHeight: .infinity)
                            .background(DodamColor.Background.normal)
                            .clipShape(.large)
                        }
                    }
                } else {
                    Text("급식을\n불러올 수 없어요")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
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
    MealWidgetContent(entry: .empty)
}
