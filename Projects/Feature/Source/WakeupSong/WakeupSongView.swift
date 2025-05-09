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
import Shared

struct WakeupSongView: View {
    
    @DodamDialog private var dialog
    @StateObject var viewModel = WakeupSongViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "기상송") {
            VStack(alignment: .leading, spacing: 0) {
                Text("오늘의 기상송")
                    .headline(.bold)
                    .foreground(DodamColor.Label.normal)
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
                            .body1(.bold)
                            .foreground(DodamColor.Label.assistive)
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
                                        .body1(.bold)
                                        .foreground(DodamColor.Label.assistive)
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
                                                let dialog = Dialog(title: "기상송을 삭제하시겠습니까?")
                                                    .primaryButton("삭제") {
                                                        Task {
                                                            await viewModel.deleteWakeupSong(
                                                                id: data.id
                                                            )
                                                            await viewModel.fetchMyWakeupSong()
                                                            await viewModel.fetchPendingWakeupSong()
                                                        }
                                                    }
                                                    .secondaryButton("취소")
                                                self.dialog.present(dialog)
                                            } label: {
                                                WakeupSongCell(
                                                    data: data
                                                )
                                            }
                                            .scaledButtonStyle()
                                        }
                                    } else {
                                        Text("기상송을 신청해 보세요")
                                            .body1(.bold)
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
                    let dialog = Dialog(title: "로그인이 필요한 기능입니다")
                        .message("로그인하시겠습니까?")
                        .primaryButton("로그인") {
                            flow.push(LoginView())
                        }
                        .secondaryButton("취소")
                    self.dialog.present(dialog)
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
