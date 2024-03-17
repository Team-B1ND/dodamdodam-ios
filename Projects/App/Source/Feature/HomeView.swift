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
                    EmptyDataButton(
                        title: "내일 급식 보러가기",
                        subTitle: "오늘은 급식이 없어요"
                    )
                }
                DodamContainer.default(
                    title: "오늘의 기상송",
                    icon: Image(.note)
                ) {
                    EmptyDataButton(
                        title: "기상송 신청하기",
                        subTitle: "승인된 기상송이 없어요"
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
                        EmptyDataButton(
                            title: "외출/외박 신청하기",
                            subTitle: "외출, 외박이 필요하다면"
                        )
                        EmptyDataButton(
                            title: "외출/외박 신청하기",
                            subTitle: "외출, 외박이 필요하다면"
                        )
                    }
                    DodamContainer.default(
                        title: "심야 자습",
                        icon: Image(.moonPlus)
                    ) {
                        EmptyDataButton(
                            title: "심야 자습 신청하기",
                            subTitle: "공부할 시간이 필요하다면"
                        )
                    }
                }
                DodamContainer.default(
                    title: "가까운 일정",
                    icon: Image(.calendar)
                ) {
                    EmptyDataButton(
                        title: "전체 일정 확인하기",
                        subTitle: "한달 간 일정이 없어요"
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
    
    private struct EmptyDataButton: View {
        
        let title: String
        let subTitle: String
        
        init(
            title: String,
            subTitle: String
        ) {
            self.title = title
            self.subTitle = subTitle
        }

        var body: some View {
            Button {
                
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    Text(subTitle)
                        .font(.dodamLabel2)
                        .foregroundStyle(Color(.tertiary))
                    Text(title)
                        .font(.dodamTitle3)
                        .foregroundStyle(Color(.primary))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    HomeView()
}
