//
//  HomeView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                DodamContainer.default(
                    title: "오늘의 급식",
                    icon: Image(.forkAndKnife)
                ) {
//                    EmptyDataButton(
//                        title: "내일 급식 보러가기",
//                        subTitle: "오늘은 급식이 없어요"
//                    )
                    MealContainer()
                }
                DodamContainer.default(
                    title: "오늘의 기상송",
                    icon: Image(.note)
                ) {
                    SupportingContainer(
                        subTitle: "승인된 기상송이 없어요",
                        title: "기상송 신청하기"
                    )
                }
                .arrowButtonAction {
                    print("화살표 액션")
                }
                
                HStack(alignment: .top, spacing: 12) {
                    DodamContainer.default(
                        title: "외출 외박",
                        icon: Image(.door)
                    ) {
                        SupportingContainer(
                            subTitle: "외출, 외박이 필요하다면",
                            title: "외출/외박 신청하기"
                        )
                        SupportingContainer(
                            subTitle: "외출이 거절되었어요",
                            title: "다시 신청하기"
                        )
                    }
                    DodamContainer.default(
                        title: "심야 자습",
                        icon: Image(.moonPlus)
                    ) {
                        SupportingContainer(
                            subTitle: "공부할 시간이 필요하다면",
                            title: "다시 신청하기"
                        )
                        SupportingContainer(
                            subTitle: "심야 자습이 거절되었어요",
                            title: "외출/외박 신청하기"
                        )
                    }
                }
                DodamContainer.default(
                    title: "가까운 일정",
                    icon: Image(.calendar)
                ) {
                    SupportingContainer(
                        subTitle: "한달 간 일정이 없어요",
                        title: "전체 일정 확인하기"
                    )
                }
                .arrowButtonAction {
                    print("화살표 액션")
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color(.surface))
    }
}

#Preview {
    HomeView()
}
