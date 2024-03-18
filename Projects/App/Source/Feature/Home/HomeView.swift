//
//  HomeView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var mealIdx: Int = -1
    @Flow var flow
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                BannerContainer(
                    data: nil
                )
                DodamContainer.default(
                    title: "오늘의 " + { () -> String in
                        switch mealIdx {
                        case 0: return "아침"
                        case 1: return "점심"
                        case 2: return "저녁"
                        default: return "급식"
                        }
                    }(),
                    icon: Image(.forkAndKnife)
                ) {
                    Button {
                        // navigate action
                    } label: {
                        MealContainer(
                            data: nil,
                            mealIdx: $mealIdx
                        )
                    }
                    .scaledButtonStyle()
                }
                DodamContainer.default(
                    title: "오늘의 기상송",
                    icon: Image(.note)
                ) {
                    Button {
                        // navigate action
                    } label: {
                        WakeupSongContainer(data: nil)
                            .padding(6)
                    }
                    .scaledButtonStyle()
                }
                .arrowButtonAction {
                    print("화살표 액션")
                }
                
                HStack(alignment: .top, spacing: 12) {
                    DodamContainer.default(
                        title: "외출 외박",
                        icon: Image(.door)
                    ) {
                        Button {
                            // navigate action
                        } label: {
                            OutStatusContainer(data: nil)
                                .padding(6)
                        }
                        .scaledButtonStyle()
                    }
                    DodamContainer.default(
                        title: "심야 자습",
                        icon: Image(.moonPlus)
                    ) {
                        Button {
                            // navigate action
                        } label: {
                            NightStudyStatusContainer(data: nil)
                                .padding(6)
                        }
                        .scaledButtonStyle()
                    }
                }
                DodamContainer.default(
                    title: "가까운 일정",
                    icon: Image(.calendar)
                ) {
                    Button {
                        // navigate action
                    } label: {
                        ScheduleContainer(data: nil)
                            .padding(6)
                    }
                    .scaledButtonStyle()
                }
                .arrowButtonAction {
                    print("화살표 액션")
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 58)
        }
        .overlay(alignment: .top) {
            HStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 88, height: 22)
                    .foregroundStyle(Color(.primary))
                    .padding(.leading, 20)
                Spacer()
                Button {
                    // bell action
                } label: {
                    Image(.bell)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(.tertiary))
                }
                .frame(width: 44, height: 44)
                .padding(.trailing, 12)
            }
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
        .background(Color(.surface))
    }
}

#Preview {
    HomeView()
}
