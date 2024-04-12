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
    
    @StateObject var viewModel = HomeViewModel()
    @Flow var flow
    @Binding var selection: Int
    @State private var ringABellRight = false
    @State private var ringABellLeft = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            DodamScrollView.icon(
                icon: viewModel.ringCount >= 33 ? .domomLogo : .logo
            ) {
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
                            flow.push(WakeupSongView())
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
                            if Sign.isLoggedIn {
                                Button {
                                    selection = 2
                                } label: {
                                    OutStatusContainer(
                                        data: viewModel.outGoingData
                                    )
                                    .padding(6)
                                }
                                .scaledButtonStyle()
                            } else {
                                Button {
                                    flow.push(LoginView())
                                } label: {
                                    SupportingContainer(
                                        subTitle: "외출, 외박을 신청하려면",
                                        title: "로그인하세요"
                                    )
                                    .padding(6)
                                }
                                .scaledButtonStyle()
                            }
                        }
                        DodamContainer.default(
                            title: "심야 자습",
                            icon: Dodam.icon(.moonPlus)
                        ) {
                            if Sign.isLoggedIn {
                                Button {
                                    selection = 3
                                } label: {
                                    NightStudyStatusContainer(
                                        data: viewModel.nightStudyData
                                    )
                                    .padding(6)
                                }
                                .scaledButtonStyle()
                            } else {
                                Button {
                                    flow.push(LoginView())
                                } label: {
                                    SupportingContainer(
                                        subTitle: "심야 자습을 신청하려면",
                                        title: "로그인하세요"
                                    )
                                    .padding(6)
                                }
                                .scaledButtonStyle()
                            }
                        }
                    }
                }
                .environment(\.isFirstLoad, viewModel.isFirstLoad)
                .padding(.horizontal, 16)
            }
            .background(Dodam.color(.surface))
            .task {
                await viewModel.onAppear()
                viewModel.ringCount = 0
            }
            .refreshable {
                await viewModel.onRefresh()
            }
            .alert(
                "도담도담에 무언가 변화가 생겼습니다.",
                isPresented: $viewModel.isShowingAlert
            ) {
                Button("확인", role: .none) { }
            }
            
            // easter egg
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    ringABellRight.toggle()
                }
                viewModel.ringCount += 1
                if viewModel.ringCount == 50 {
                    viewModel.isShowingAlert.toggle()
                }
            } label: {
                Image(icon: .bell)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .frame(width: 48, height: 48)
                    .rotationEffect(.degrees(ringABellRight ? -30 : 0))
                    .rotationEffect(.degrees(ringABellLeft ? 30 : 0))
            }
            .dodamColor(.onSurfaceVariant)
            .onChange(of: ringABellRight) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            ringABellRight = false
                            withAnimation(.easeInOut(duration: 0.2)) {
                                ringABellLeft = true
                            }
                        }
                    }
                }
            }
            .onChange(of: ringABellLeft) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            ringABellLeft = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(selection: .constant(0))
}
