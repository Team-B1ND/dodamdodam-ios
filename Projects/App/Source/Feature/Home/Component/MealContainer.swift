//
//  MealContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

struct MealContainer: View {
    
    private let mealData: Meal?
    @Binding var mealIdx: Int
    
    public init(
        data mealData: Meal?,
        mealIdx: Binding<Int>
    ) {
        self.mealData = mealData
        self._mealIdx = mealIdx
    }
    
    var body: some View {
        if let data = mealData {
            DodamPageView(selection: $mealIdx) {
                ForEach([
                    data.breakfast.details,
                    data.lunch.details,
                    data.dinner.details
                ], id: \.self
                ) { meals in
                    Text(meals.map { $0.name }.joined(separator: ", "))
                        .font(.body(.medium))
                        .dodamColor(.onSurfaceVariant)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 6)
                        .page()
                }
            }
            .frame(maxHeight: 50)
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
                    } else if hour < 19 || (hour == 19 && minute < 20) {
                        mealIdx = 2
                    } else {
                        // 다음 날 가져와서 표시
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

#Preview {
    struct MealContainerPreview: View {
        
        let dummyData = Meal(
            exists: true,
            date: "2024-03-07",
            breakfast: MealDetails(
                details: [
                    MealItem(name: "전복죽", allergies: [18]),
                    MealItem(name: "모닝빵/버터/딸기잼", allergies: [1, 2, 5, 6, 13]),
                    MealItem(name: "샐러드바/드레싱", allergies: [1, 2, 5, 6, 12]),
                    MealItem(name: "나박김치", allergies: [9]),
                    MealItem(name: "시리얼(콘앤스위트)&우유", allergies: [2, 5, 6])
                ],
                calorie: 647.7
            ),
            lunch: MealDetails(
                details: [
                    MealItem(name: "흑미밥", allergies: []),
                    MealItem(name: "왕만두육개장", allergies: [1, 5, 6, 10, 16, 18]),
                    MealItem(name: "고등어무조림", allergies: [5, 6, 7, 13]),
                    MealItem(name: "취나물무침", allergies: [5, 6]),
                    MealItem(name: "배추김치", allergies: [9]),
                    MealItem(name: "롤링핫도그", allergies: [1, 2, 5, 6, 10, 12, 15, 18])
                ],
                calorie: 945.5
            ),
            dinner: MealDetails(
                details: [
                    MealItem(name: "혼합잡곡밥(10곡)", allergies: [5]),
                    MealItem(name: "손수제비국", allergies: [5, 6, 9]),
                    MealItem(name: "묵은지김치찜", allergies: [5, 6, 9, 10, 13]),
                    MealItem(name: "동태전", allergies: [1, 5, 6, 13]),
                    MealItem(name: "배추김치", allergies: [9]),
                    MealItem(name: "주스", allergies: [13])
                ],
                calorie: 1114.4
            )
        )
        @State var dummyMealIdx1: Int = -1
        @State var dummyMealIdx2: Int = -1
        
        var body: some View {
            VStack(spacing: 12) {
                DodamContainer.default(
                    title: "오늘의 " + { () -> String in
                        switch dummyMealIdx1 {
                        case 0: return "아침"
                        case 1: return "점심"
                        case 2: return "저녁"
                        default: return "급식"
                        }
                    }(),
                    icon: Dodam.icon(.forkAndKnife)
                ) {
                    Button {
                        // navigate action
                    } label: {
                        MealContainer(
                            data: dummyData,
                            mealIdx: $dummyMealIdx1
                        )
                    }
                    .scaledButtonStyle()
                }
                DodamContainer.default(
                    title: "오늘의 " + { () -> String in
                        switch dummyMealIdx2 {
                        case 0: return "아침"
                        case 1: return "점심"
                        case 2: return "저녁"
                        default: return "급식"
                        }
                    }(),
                    icon: Dodam.icon(.forkAndKnife)
                ) {
                    Button {
                        // navigate action
                    } label: {
                        MealContainer(
                            data: nil,
                            mealIdx: $dummyMealIdx2
                        )
                    }
                    .scaledButtonStyle()
                }
            }
            .padding(16)
            .background(Dodam.color(.surface))
        }
    }
    return MealContainerPreview()
}

public struct Meal: Codable, Hashable {
    let exists: Bool
    let date: String
    let breakfast: MealDetails
    let lunch: MealDetails
    let dinner: MealDetails
}

public struct MealDetails: Codable, Hashable {
    let details: [MealItem]
    let calorie: Double
}

public struct MealItem: Codable, Hashable {
    let name: String
    let allergies: [Int]
}
