//
//  MealContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

struct MealContainer: View {
    
    private let mealData: MealResponse?
    @Binding var mealIdx: Int
    
    public init(
        data mealData: MealResponse?,
        mealIdx: Binding<Int>
    ) {
        self.mealData = mealData
        self._mealIdx = mealIdx
    }
    
    var body: some View {
        if let data = mealData {
            DodamPageView(selection: $mealIdx) {
                ForEach([
                    data.breakfast,
                    data.lunch,
                    data.dinner
                ], id: \.self
                ) { meals in
                    Text(meals?.details.map {
                        $0.name
                    }.joined(separator: ", ") ?? "")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 6)
                    .page()
                }
            }
            .frame(height: 50)
            .padding(6)
            .onAppear {
                let currentTime = Date()
                let calendar = Calendar.current
                let components = calendar.dateComponents([.hour, .minute], from: currentTime)
                
                if let hour = components.hour, let minute = components.minute {
                    if hour < 8 || (hour == 8 && minute < 30) {
                        mealIdx = 0
                    } else if hour < 13 || (hour == 13 && minute < 30) {
                        mealIdx = 1
                    } else {
                        mealIdx = 2
                    }
                }
            }
        } else {
            SupportingContainer(
                subTitle: "오늘은 급식이 없어요",
                title: "내일 급식 보러가기"
            )
            .padding(6)
        }
    }
}
