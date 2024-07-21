//
//  NightStudyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import SwiftUI
import FlowKit
import DDS
import SignKit

struct NightStudyView: View {
    
    @StateObject var viewModel = NightStudyViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "심야 자습") {
            VStack(spacing: 20) {
                if Sign.isLoggedIn {
                    if let data = viewModel.nightStudyData {
                        if !data.isEmpty {
                            ForEach(data, id: \.self) { data in
                                NightStudyApplyCell(
                                    data: data
                                )
                                .contextMenu {
                                    Button(role: .destructive) {
                                        let alert = Alert(
                                            title: "해당 심야 자습을 삭제하시겠습니까?",
                                            primaryButton: .destructive("삭제") {
                                                Task {
                                                    await viewModel.deleteNightStudy(
                                                        id: data.id
                                                    )
                                                }
                                            },
                                            secondaryButton: .cancel("취소")
                                        )
                                        flow.alert(alert)
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                }
                            }
                        } else {
                            DodamEmptyView(
                                title: "아직 신청한 심야 자습이 없어요.",
                                icon: .fullMoonFace,
                                buttonTitle: "심야 자습 신청하기"
                            ) {
                                flow.push(NightStudyApplyView())
                            }
                        }
                    } else {
                        DodamLoadingView()
                    }
                } else {
                    DodamEmptyView(
                        title: "심야 자습을 신청하려면 로그인하세요.",
                        icon: .fullMoonFace,
                        buttonTitle: "로그인"
                    ) {
                        flow.push(LoginView())
                    }
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .button(icon: .plus, hidden: !Sign.isLoggedIn) {
            flow.push(NightStudyApplyView())
        }
        .borderSize(16)
//        .background(Dodam.color(.surface))
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

#Preview {
    NightStudyView()
}
