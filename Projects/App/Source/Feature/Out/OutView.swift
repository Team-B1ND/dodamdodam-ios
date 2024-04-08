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
                                        let alert = Alert(
                                            title: "해당 외출 신청을 삭제하시겠습니까?",
                                            primaryButton: .destructive("삭제") {
                                                Task {
                                                    await viewModel.deleteOutGoing(
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
                                        let alert = Alert(
                                            title: "해당 외박 신청을 삭제하시겠습니까?",
                                            primaryButton: .destructive("삭제") {
                                                Task {
                                                    await viewModel.deleteOutSleeping(
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
        .button(icon: .plus, hidden: !Sign.isLoggedIn) {
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
