//
//  ApproveNightStudyView.swift
//  Feature
//
//  Created by 김은찬 on 7/7/25.
//

import SwiftUI
import DDS
import SignKit
import Shared
import Domain

struct ApproveNightStudyView: View {
    @StateObject private var viewModel = ApproveNightStudyViewModel()
    @DodamDialog private var dialog
    
    var body: some View {
        DodamScrollView.medium(
            title: "심야 자습 승인"
        ) {
            VStack(spacing: 20) {
                Text("심자 승인 대기중인 학생")
                    .font(.heading2(.bold))
                    .foreground(DodamColor.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(2)
                
                DodamTextField.default(
                    title: "학생 검색",
                    text: $viewModel.searchText
                )
                .onSubmit {}
                .padding(.horizontal, 8)
                
                if let _ = viewModel.pendingNightStudy {
                    VStack(spacing: 8) {
                        PendingStudentInfoHeader()
                            .padding(.vertical, 4)
                        
                        ForEach(viewModel.filteredStudents, id: \.id) { data in
                            PendingNightStudyStudentCell(
                                data: data,
                                isSelected: viewModel.studentInfo?.id == data.id
                            ) {
                                viewModel.studentInfo = data
                                viewModel.isModalPresented = true
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .padding(12)
                    .background(DodamColor.Background.normal)
                    .clipShape(.medium)
                } else {
                    DodamLoadingView()
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .subView {
            DodamSegmentedButton(
                labels: ["전체", "1학년", "2학년", "3학년"],
                selection: $viewModel.selectedGradeIndex
            )
            DodamSegmentedButton(
                labels: ["전체", "1반", "2반", "3반", "4반"],
                selection: $viewModel.selectedClassIndex
            )
        }
        .dodamSheet(isPresented: $viewModel.isModalPresented) {
            Text("z")
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
    ApproveNightStudyView()
}
