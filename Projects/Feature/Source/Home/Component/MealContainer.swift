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
    private let mealData: MealModel?
    @Binding var mealType: MealType?
    
    init(
        data mealData: MealModel?,
        mealType: Binding<MealType?>
    ) {
        self.mealData = mealData
        self._mealType = mealType
    }
    
    var body: some View {
        if let data = mealData {
            if data.exists {
                DodamPageView(
                    selection: .init {
                        mealType?.rawValue ?? -1
                    } set: {
                        mealType = MealType(rawValue: $0)
                    }
                ) {
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
                    self.mealType = MealType.from(.now) ?? .breakfast
                }
            } else {
                let notExistMeal = MealType.from(.now) == nil
                SupportingContainer(
                    subTitle: notExistMeal ? "내일의 급식정보가 없어요" : "오늘은 급식이 없어요",
                    title: "급식 정보 보러가기"
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
