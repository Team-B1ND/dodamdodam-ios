//
//  OutView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import FlowKit
import SwiftUI
import DDS
import SignKit
import Shared

struct OutView: View {
    
    @DodamDialog private var dialog
    @StateObject var viewModel = OutViewModel()
    @Flow var flow
    
    @State var selection: Int = 0
    
    var body: some View {
        DodamScrollView.default(title: "외출/외박") {
            VStack(spacing: 12) {
                if selection == 0 {
                    if Sign.isLoggedIn {
                        if let data = viewModel.outGoingData {
                            if !data.isEmpty {
                                ForEach(data, id: \.self) { data in
                                    OutGoingCell(
                                        data: data
                                    )
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            let dialog = Dialog(title: "해당 외출 신청을 삭제하시겠습니까?")
                                                .primaryButton("삭제") {
                                                    Task {
                                                        await viewModel.deleteOutGoing(
                                                            id: data.id
                                                        )
                                                    }
                                                }
                                                .secondaryButton("취소")
                                            self.dialog.present(dialog)
                                        } label: {
                                            Label("삭제", systemImage: "trash")
                                        }
                                    }
                                }
                            } else {
                                DodamEmptyView(
                                    title: "아직 신청한 외출이 없어요.",
                                    icon: .convenienceStore,
                                    buttonTitle: "외출 신청하기"
                                ) {
                                    flow.push(OutApplyView(
                                        selected: $selection
                                    ))
                                }
                            }
                        } else {
                            DodamLoadingView()
                        }
                    } else {
                        DodamEmptyView(
                            title: "외출을 신청하려면 로그인하세요.",
                            icon: .convenienceStore,
                            buttonTitle: "로그인"
                        ) {
                            flow.push(LoginView())
                        }
                    }
                }
                if selection == 1 {
                    if Sign.isLoggedIn {
                        if let data = viewModel.outSleepingData {
                            if !data.isEmpty {
                                ForEach(data, id: \.self) { data in
                                    OutSleepingCell(
                                        data: data
                                    )
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            let dialog = Dialog(title: "해당 외박 신청을 삭제하시겠습니까?")
                                                .primaryButton("삭제") {
                                                    Task {
                                                        await viewModel.deleteOutSleeping(
                                                            id: data.id
                                                        )
                                                    }
                                                }
                                                .secondaryButton("취소")
                                            self.dialog.present(dialog)
                                        } label: {
                                            Label("삭제", systemImage: "trash")
                                        }
                                    }
                                }
                            } else {
                                DodamEmptyView(
                                    title: "아직 신청한 외박이 없어요.",
                                    icon: .tent,
                                    buttonTitle: "외박 신청하기"
                                ) {
                                    flow.push(OutApplyView(
                                        selected: $selection
                                    ))
                                }
                            }
                        } else {
                            DodamLoadingView()
                        }
                    } else {
                        DodamEmptyView(
                            title: "외박을 신청하려면 로그인하세요.",
                            icon: .tent,
                            buttonTitle: "로그인"
                        ) {
                            flow.push(LoginView())
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .subView {
            DodamSegmentedButton(
                labels: ["외출", "외박"],
                selection: $selection
            )
        }
        .button(icon: .plus, hidden: !Sign.isLoggedIn) {
            flow.push(OutApplyView(
                selected: $selection
            ))
        }
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

#Preview {
    OutView()
}
