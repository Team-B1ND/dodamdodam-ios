//
//  NightStudyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import SwiftUI
import DDS
import SignKit
import Shared
import Domain
import FlowKit

struct NightStudyView: View {
    @StateObject private var viewModel = NightStudyViewModel()
    @DodamDialog private var dialog
    @State var selection: Int = 0
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "심야 자습") {
            VStack(spacing: 20) {
                if Sign.isLoggedIn {
                    if selection == 0 {
                        if let data = viewModel.nightStudyData {
                            if !data.isEmpty {
                                ForEach(data, id: \.id) { data in
                                    NightStudyApplyCell(data: data) {
                                        let dialog = Dialog(title: "해당 심야 자습을 삭제하시겠습니까?")
                                            .primaryButton("삭제") {
                                                Task {
                                                    await viewModel.deleteNightStudy(id: data.id)
                                                }
                                            }
                                            .secondaryButton("취소")
                                        self.dialog.present(dialog)
                                    }
                                }
                            } else {
                                DodamEmptyView(
                                    title: "아직 신청한 심야 자습이 없어요.",
                                    icon: .fullMoonFace,
                                    buttonTitle: "심야 자습 신청하기"
                                ) {
                                    flow.push(ApplyView())
                                }
                            }
                        } else {
                            DodamLoadingView()
                        }
                    }
                    
                    if selection == 1 {
                        if let data = viewModel.nightProjectData {
                            if !data.isEmpty {
                                ForEach(data, id: \.id) { project in
                                    NightProjectApplyCell(data: project) {
                                        let dialog = Dialog(title: "해당 프로젝트 심자를 삭제하시겠습니까?")
                                            .primaryButton("삭제") {
                                                Task {
                                                    await viewModel.deleteNightStudyProject(id: project.id)
                                                }
                                            }
                                            .secondaryButton("취소")
                                        self.dialog.present(dialog)
                                    }
                                }
                            } else {
                                DodamEmptyView(
                                    title: "아직 신청한 프로젝트 심자가 없어요.",
                                    icon: .fullMoonFace,
                                    buttonTitle: "프로젝트 심자 신청하기"
                                ) {
                                    flow.push(ApplyView())
                                }
                            }
                        } else {
                            DodamLoadingView()
                        }
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
        .subView {
            DodamSegmentedButton(
                labels: ["개인", "프로젝트"],
                selection: $selection
            )
        }
        .button(icon: .plus, hidden: !Sign.isLoggedIn || viewModel.isBanned) {
            flow.push(ApplyView())
        }
        .borderSize(16)
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

//                            if viewModel.isBanned {
//                                DodamEmptyView(
//                                    title: "심야 자습 신청이 제한된 상태입니다.\n\n사유: \(viewModel.banPeriod?.banReason ?? "")",
//                                    icon: .fullMoonFace,
//                                    buttonTitle: viewModel.banPeriod.map { "\($0.started) ~ \($0.ended)" } ?? "",
//                                    action: {}
//                                )
//                            } else {
//                            }
