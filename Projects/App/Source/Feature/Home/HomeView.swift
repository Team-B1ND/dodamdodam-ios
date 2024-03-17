//
//  HomeView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import SwiftUI

struct HomeView: View {
    
    // test data
    let banner: [String] = ["https://zrr.kr/lzRi"]
    let outGoingStatus: String = "ALLOWED"
    let nightStudyStatus: String = "PENDING"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                if !banner.isEmpty {
                    TabView {
                        ForEach(banner, id: \.self) { image in
                            Link(destination: URL(string: "https://url.kr/49letc") ?? URL(string: "about:blank")!) {
                                AsyncImage(url: URL(string: image)) { image in
                                    image
                                        .resizable()
                                } placeholder: {
                                    Rectangle()
                                        .opacity(0.5)
                                }
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .aspectRatio(80/12, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                DodamContainer.default(
                    title: "오늘의 아침",
                    icon: Image(.forkAndKnife)
                ) {
                    MealContainer()
                }
                DodamContainer.default(
                    title: "오늘의 저녁",
                    icon: Image(.forkAndKnife)
                ) {
                    Button {
                        
                    } label: {
                        SupportingContainer(
                            subTitle: "오늘은 급식이 없어요",
                            title: "내일 급식 보러가기"
                        )
                    }
                }
                DodamContainer.default(
                    title: "오늘의 기상송",
                    icon: Image(.note)
                ) {
                    Button {
                        
                    } label: {
                        SupportingContainer(
                            subTitle: "승인된 기상송이 없어요",
                            title: "기상송 신청하기"
                        )
                    }
                }
                DodamContainer.default(
                    title: "오늘의 기상송",
                    icon: Image(.note)
                ) {
                    WakeupSongContainer()
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
                            if outGoingStatus == "ALLOWED" ||
                                outGoingStatus == "PENDING" {
                                StatusContainer(
                                    status: outGoingStatus
                                )
                            } else if outGoingStatus == "DENY" {
                                SupportingContainer(
                                    subTitle: "외출이 거절되었어요",
                                    title: "다시 신청하기"
                                )
                            } else {
                                SupportingContainer(
                                    subTitle: "외출, 외박이 필요하다면",
                                    title: "외출/외박 신청하기"
                                )
                            }
                        }
                        // UI test
                        Group {
                            SupportingContainer(
                                subTitle: "외출이 거절되었어요",
                                title: "다시 신청하기"
                            )
                            SupportingContainer(
                                subTitle: "외출, 외박이 필요하다면",
                                title: "외출/외박 신청하기"
                            )
                        }
                    }
                    DodamContainer.default(
                        title: "심야 자습",
                        icon: Image(.moonPlus)
                    ) {
                        Button {
                            // navigate action
                        } label: {
                            if nightStudyStatus == "ALLOWED" ||
                                nightStudyStatus == "PENDING" {
                                StatusContainer(
                                    status: nightStudyStatus
                                )
                            } else if nightStudyStatus == "DENY" {
                                SupportingContainer(
                                    subTitle: "심야 자습이 거절되었어요",
                                    title: "외출/외박 신청하기"
                                )
                            } else {
                                SupportingContainer(
                                    subTitle: "공부할 시간이 필요하다면",
                                    title: "다시 신청하기"
                                )
                            }
                        }
                    }
                }
                DodamContainer.default(
                    title: "가까운 일정",
                    icon: Image(.calendar)
                ) {
                    ScheduleContainer()
                }
                .arrowButtonAction {
                    print("화살표 액션")
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
