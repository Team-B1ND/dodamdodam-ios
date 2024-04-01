//
//  HomeView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import SwiftUI
import DDS
import SignKit

struct HomeView: View {
    
    @InjectObject var viewModel: HomeViewModel
    @Flow var flow
    @Binding var selection: Int
    
    var body: some View {
        DodamScrollView {
            HStack {
                Dodam.icon(.logo)
                    .resizable()
                    .frame(width: 88, height: 22)
                    .dodamColor(.primary)
                    .padding(.leading, 20)
                Spacer()
                Button {
                    viewModel.isShowingAlert.toggle()
                } label: {
                    Dodam.icon(.bell)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .dodamColor(.onSurfaceVariant)
                }
                .frame(width: 44, height: 44)
                .padding(.trailing, 12)
            }
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        } content: {
            VStack(spacing: 12) {
                BannerContainer(
                    data: viewModel.bannerData
                )
                DodamContainer.default(
                    title: "오늘의 " + { () -> String in
                        switch viewModel.mealIdx {
                        case 0: return "아침"
                        case 1: return "점심"
                        case 2: return "저녁"
                        default: return "급식"
                        }
                    }(),
                    icon: Dodam.icon(.forkAndKnife)
                ) {
                    Button {
                        selection = 1
                    } label: {
                        MealContainer(
                            data: viewModel.mealData,
                            mealIdx: $viewModel.mealIdx
                        )
                    }
                    .scaledButtonStyle()
                }
                DodamContainer.default(
                    title: "오늘의 기상송",
                    icon: Dodam.icon(.note)
                ) {
                    Button {
                        
                    } label: {
                        WakeupSongContainer(
                            data: viewModel.wakeupSongData
                        )
                        .padding(6)
                    }
                    .scaledButtonStyle()
                }
                HStack(alignment: .top, spacing: 12) {
                    DodamContainer.default(
                        title: "외출 외박",
                        icon: Dodam.icon(.doorOpen)
                    ) {
                        Button {
                            selection = 2
                        } label: {
                            OutStatusContainer(
                                data: viewModel.outGoingData
                            )
                            .padding(6)
                        }
                        .scaledButtonStyle()
                    }
                    DodamContainer.default(
                        title: "심야 자습",
                        icon: Dodam.icon(.moonPlus)
                    ) {
                        Button {
                            selection = 3
                        } label: {
                            NightStudyStatusContainer(
                                data: viewModel.nightStudyData
                            )
                            .padding(6)
                        }
                        .scaledButtonStyle()
                    }
                }
                DodamContainer.default(
                    title: "가까운 일정",
                    icon: Dodam.icon(.calendar)
                ) {
                    Button {
                        // navigate action
                    } label: {
                        /*
                        ScheduleContainer(
                            data: viewModel.scheduleData
                        )
                        .padding(6)
                         */
                    }
                    .scaledButtonStyle()
                }
                Button {
                    Sign.logout()
                } label: {
                    Text("로그아웃")
                }
            }
            .padding(.horizontal, 16)
        }
        .task {
            await viewModel.onAppear()
        }
        .alert("앗", isPresented: $viewModel.isShowingAlert) {
            Button("확인", role: .none) {
                viewModel.isShowingAlert.toggle()
            }
        } message: {
            Text("해당 기능은 곧 추가될 예정이에요")
        }
    }
}

#Preview {
    HomeView(selection: .constant(0))
}
