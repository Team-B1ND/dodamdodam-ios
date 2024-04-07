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
    
    @State var selection: Int = 0
    
    var body: some View {
        DodamScrollView.default(title: "외출/외박") {
            VStack(spacing: 12) {
                if selection == 0 {
                    if let data = viewModel.outGoingData {
                        if !data.isEmpty {
                            ForEach(data, id: \.self) { data in
                                OutGoingCell(
                                    data: data
                                )
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.isShowingDeleteAlert.toggle()
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                }
                                .alert(
                                    "해당 외출 신청을 삭제하시겠습니까?",
                                    isPresented: $viewModel.isShowingDeleteAlert
                                ) {
                                    Button("삭제", role: .destructive) {
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
                                flow.push(OutApplyView(
                                    selected: $selection
                                ))
                            }
                        }
                    } else {
                        DodamLoadingView()
                    }
                }
                if selection == 1 {
                    if let data = viewModel.outSleepingData {
                        if !data.isEmpty {
                            ForEach(data, id: \.self) { data in
                                OutSleepingCell(
                                    data: data
                                )
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.isShowingDeleteAlert.toggle()
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                }
                                .alert(
                                    "해당 외박 신청을 삭제하시겠습니까?",
                                    isPresented: $viewModel.isShowingDeleteAlert
                                ) {
                                    Button("삭제", role: .destructive) {
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
                                flow.push(OutApplyView(
                                    selected: $selection
                                ))
                            }
                        }
                    } else {
                        DodamLoadingView()
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .subView {
            SegmentedView(
                labels: ["외출", "외박"],
                selection: $selection
            )
        }
        .button(icon: .plus) {
            flow.push(OutApplyView(
                selected: $selection
            ))
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
