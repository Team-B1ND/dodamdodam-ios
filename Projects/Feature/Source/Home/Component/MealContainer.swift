//
//  MealContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS
import Domain
import Shared

struct MealContainer: View {
    
    @State private var pageSize: CGSize?
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
            if data.exists {
                DodamPageView(selection: $mealIdx) {
                    ForEach(data.meals, id: \.self) { meal in
                        let splitedArray = splitArray(array: meal.details)
                        HStack(alignment: .top) {
                            ForEach(splitedArray, id: \.self) { meals in
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach(meals, id: \.self) { meal in
                                        Text(meal.name)
                                            .body1(.medium)
                                            .foreground(DodamColor.Label.normal)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .onReadSize { size in
                            self.pageSize = size
                        }
                        .page()
                    }
                }
                .frame(height: pageSize?.height ?? 0 > 86 ? pageSize?.height ?? 0 : 86)
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
            }
        } else {
            DodamLoadingView()
                .frame(height: 61.928)
        }
    }
}

#Preview {
    HomeView(selection: .constant(0))
}
