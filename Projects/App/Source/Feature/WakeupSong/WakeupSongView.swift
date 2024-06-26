//
//  WakeupSongView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import FlowKit
import SignKit

struct WakeupSongView: View {
    
    @StateObject var viewModel = WakeupSongViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "기상송") {
            VStack(alignment: .leading, spacing: 0) {
                Text("내일의 기상송")
                    .font(.title(.medium))
                    .dodamColor(.onBackground)
                if let data = viewModel.allowedWakeupSongData {
                    if !data.isEmpty {
                        LazyVStack(spacing: 4) {
                            ForEach(
                                Array(data.enumerated()),
                                id: \.element
                            ) { index, element in
                                TomorrowWakeupSongCell(
                                    data: element,
                                    id: index + 1
                                )
                            }
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 6)
                    } else {
                        Text("승인된 기상송이 아직 없어요.")
                            .font(.label(.large))
                            .dodamColor(.tertiary)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .center
                            )
                            .padding(.vertical, 40)
                    }
                } else {
                    DodamLoadingView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 40)
                }
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    DodamTopTabView {
                        LazyVStack(spacing: 4) {
                            if let data = viewModel.pendingWakeupSongData {
                                if !data.isEmpty {
                                    ForEach(data, id: \.self) { data in
                                        WakeupSongCell(
                                            data: data
                                        )
                                    }
                                } else {
                                    Text("대기중인 기상송이 없어요")
                                        .font(.body(.medium
                                                   ))
                                        .dodamColor(.tertiary)
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .center
                                        )
                                        .padding(.top, 40)
                                }
                            } else {
                                DodamLoadingView()
                                    .padding(.top, 40)
                            }
                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 150)
                        .page(.text("대기중"))
                        
                        LazyVStack(spacing: 4) {
                            if Sign.isLoggedIn {
                                if let data = viewModel.myWakeupSongData {
                                    if !data.isEmpty {
                                        ForEach(data, id: \.self) { data in
                                            Button {
                                                viewModel.showDialog = true
                                            } label: {
                                                WakeupSongCell(
                                                    data: data
                                                )
                                            }
                                            .scaledButtonStyle()
                                            .alert(
                                                "기상송을 삭제하시겠습니까?",
                                                isPresented: $viewModel.showDialog
                                            ) {
                                                Button("네", role: .none) {
                                                    Task {
                                                        await viewModel.deleteWakeupSong(
                                                            id: data.id
                                                        )
                                                        await viewModel.fetchMyWakeupSong()
                                                        await viewModel.fetchPendingWakeupSong()
                                                    }
                                                }
                                                Button("취소", role: .cancel) { }
                                            }
                                        }
                                    } else {
                                        Text("기상송을 신청해 보세요")
                                            .font(.body(.medium
                                                       ))
                                            .dodamColor(.tertiary)
                                            .frame(
                                                maxWidth: .infinity,
                                                alignment: .center
                                            )
                                            .padding(.top, 40)
                                    }
                                } else {
                                    DodamLoadingView()
                                        .padding(.top, 40)
                                }
                            } else {
                                DodamEmptyView(
                                    title: "기상송을 신청하려면 로그인하세요.",
                                    icon: .note,
                                    buttonTitle: "로그인"
                                ) {
                                    flow.push(LoginView())
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(
                                            Dodam.color(.secondaryContainer),
                                            lineWidth: 2
                                        )
                                )
                            }
                            Spacer()
                        }
                        .padding(.top, 12)
                        .page(.text("MY"))
                    }
                    .padding(.top, 15)
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
        }
        .overlay(alignment: .bottom) {
            DodamButton.fullWidth(
                title: "기상송 신청하기"
            ) {
                if Sign.isLoggedIn {
                    flow.push(WakeupSongApplyView())
                } else {
                    let alert = Alert(
                        title: "로그인이 필요한 기능입니다",
                        message: "로그인하시겠습니까?",
                        primaryButton: .default("로그인") {
                            flow.push(LoginView())
                        },
                        secondaryButton: .cancel("취소")
                    )
                    flow.alert(alert)
                }
            }
            .padding([.bottom, .horizontal], 16)
        }
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

#Preview {
    FlowPreview {
        WakeupSongView()
    }
}
