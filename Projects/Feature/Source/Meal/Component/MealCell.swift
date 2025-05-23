//
//  MealCell.swift
//  Feature
//
//  Created by hhhello0507 on 8/12/24.
//

import SwiftUI
import DDS
import Domain

struct MealCell: View {
    
    private let type: MealType
    private let meal: MealDetail
    
    init(type: MealType, meal: MealDetail) {
        self.type = type
        self.meal = meal
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                DodamTag(type.label, type: .primary)
                Spacer()
                Text("\(Int(meal.calorie))Kcal")
                    .label(.medium)
                    .foreground(DodamColor.Label.alternative)
            }
            Text(meal.details.map { $0.name }.joined(separator: "\n"))
                .body1(.medium)
                .foreground(DodamColor.Label.normal)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}
