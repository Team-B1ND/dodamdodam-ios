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
        self.animatedIdx = mealIdx.wrappedValue
    }
    
    @Environment(\.isFirstLoad) private var isFirstLoad
    @State private var animatedIdx: Int
    @State private var heights: [Int: CGFloat] = .init()
    
    var body: some View {
        if let data = mealData {
            if data.exists {
                let meals = [
                    data.breakfast,
                    data.lunch,
                    data.dinner
                ]
                DodamPageView(selection: $mealIdx) {
                    ForEach(meals.indices, id: \.self) { idx in
                        GeometryReader { geometryProxy in
                            let text = meals[idx]?.details.map {
                                $0.name
                            }.joined(separator: ", ") ?? ""
                            Text(text)
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .onAppear {
                                    withAnimation(.spring) {
                                        heights[idx] = text.boundingRect(
                                            with: CGSize(
                                                width: geometryProxy.size.width,
                                                height: .greatestFiniteMagnitude
                                            ),
                                            options: .usesLineFragmentOrigin,
                                            attributes: [
                                                .font: UIFont(
                                                    name: SUIT.Weight.semibold.rawValue,
                                                    size: 18
                                                )!
                                            ],
                                            context: nil
                                        ).height
                                    }
                                }
                        }
                        .padding(.horizontal, 6)
                        .page()
                    }
                }
                .frame(height: heights[animatedIdx] ?? 44.928)
                .padding(6)
                .onChange(of: mealIdx) { newValue in
                    withAnimation(.spring(duration: 0.2)) {
                        animatedIdx = newValue
                    }
                }
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
        } else {
            DodamLoadingView()
                .frame(height: 61.928)
        }
    }
}

#Preview {
    HomeView(selection: .constant(0))
}
