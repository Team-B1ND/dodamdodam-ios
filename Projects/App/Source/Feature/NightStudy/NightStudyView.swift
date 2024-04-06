//
//  NightStudyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import SwiftUI
import DDS

struct NightStudyView: View {
    
    @InjectObject var viewModel: NightStudyViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "심야 자습") {
            VStack(spacing: 20) {
                if let data = viewModel.nightStudyData {
                    if !data.isEmpty {
                        ForEach(data, id: \.self) { data in
                            NightStudyApplyCell(
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
                                "해당 심야 자습을 삭제하시겠습니까?",
                                isPresented: $viewModel.isShowingDeleteAlert
                            ) {
                                Button("삭제", role: .destructive) {
                                    Task {
                                        await viewModel.deleteNightStudy(
                                            id: data.id
                                        )
                                    }
                                }
                                Button("취소", role: .cancel) { }
                            }
                        }
                    } else {
                        DodamEmptyView(
                            .nightStudy
                        ) {
                            flow.push(NightStudyApplyView())
                        }
                    }
                } else {
                    DodamLoadingView()
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .button(icon: .plus) {
            flow.push(NightStudyApplyView())
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
    NightStudyView()
}
