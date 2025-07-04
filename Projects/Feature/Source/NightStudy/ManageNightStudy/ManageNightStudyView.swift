//
//  ManageNightStudyView.swift
//  Feature
//
//  Created by 김은찬 on 7/4/25.
//

import SwiftUI
import DDS
import SignKit
import Shared
import Domain

struct ManageNightStudyView: View {
    @StateObject private var viewModel = ManageNightStudyViewModel()
    @State var selection: Int = 0
    var body: some View {
        DodamScrollView.small(
            title: "심자 관리"
        ) {
            VStack {
                StudentInfoHeader()
                
                if selection == 0 {
                    if let data = viewModel.allowNightStudy {
                        ForEach(data, id: \.id) { data in
                            NightStudyStudentCell(data) {
                                NightStudyStudentCell(data) {
                                    print("승인 됨")
                                }
                            }
                        }
                        .padding(8)
                        .background(DodamColor.Background.normal)
                        .clipShape(.medium)
                    } else {
                        DodamLoadingView()
                    }
                } else {
                    if let data = viewModel.pendingNightStudy {
                        ForEach(data, id: \.id) { data in
                            NightStudyStudentCell(data) {
                                NightStudyStudentCell(data) {
                                    print("대기 중")
                                }
                            }
                        }
                        .padding(8)
                        .background(DodamColor.Background.normal)
                        .clipShape(.medium)
                    } else {
                        DodamLoadingView()
                    }
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .subView {
            DodamSegmentedButton(
                labels: ["진행 중", "대기 중"],
                selection: $selection
            )
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
    ManageNightStudyView()
}
