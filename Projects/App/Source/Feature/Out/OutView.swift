//
//  OutView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import SwiftUI
import DDS

struct OutView: View {
    
    @InjectObject var viewModel: OutViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "외출/외박") {
            VStack(spacing: 12) {
                if viewModel.selection == 0 {
                    if let data = viewModel.outGoingData,
                       !data.isEmpty {
                        ForEach(data, id: \.self) { data in
                            Button {
                                viewModel.isShowingDeleteAlert.toggle()
                            } label: {
                                OutGoingCell(
                                    data: data
                                )
                            }
                            .scaledButtonStyle()
                            .alert(
                                "해당 외출 신청을 삭제하시겠습니까?",
                                isPresented: $viewModel.isShowingDeleteAlert
                            ) {
                                Button("네", role: .none) {
                                    Task {
                                        await viewModel.deleteOutGoing(
                                            id: data.id
                                        )
                                    }
                                }
                                Button("취소", role: .cancel) { }
                            }
                        }
                    } else {
                        DodamEmptyView(
                            .outGoing
                        ) {
                            flow.push(OutApplyView())
                        }
                    }
                }
                if viewModel.selection == 1 {
                    if let data = viewModel.outSleepingData,
                       !data.isEmpty {
                        ForEach(data, id: \.self) { data in
                            Button {
                                viewModel.isShowingDeleteAlert.toggle()
                            } label: {
                                OutSleepingCell(
                                    data: data
                                )
                            }
                            .scaledButtonStyle()
                            .alert(
                                "해당 외박 신청을 삭제하시겠습니까?",
                                isPresented: $viewModel.isShowingDeleteAlert
                            ) {
                                Button("네", role: .none) {
                                    Task {
                                        await viewModel.deleteOutSleeping(
                                            id: data.id
                                        )
                                    }
                                }
                                Button("취소", role: .cancel) { }
                            }
                        }
                    } else {
                        DodamEmptyView(
                            .outSleeping
                        ) {
                            flow.push(OutApplyView())
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 150)
        }
        .subView {
            SegmentedView(
                labels: ["외출", "외박"],
                selection: $viewModel.selection
            )
        }
        .button(icon: .plus) {
            flow.push(OutApplyView())
        }
        .background(Dodam.color(.surface))
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
