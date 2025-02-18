//
//  DivisionWaitingMemberView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import DDS
import SwiftUI
import Domain

struct DivisionWaitingMemberView: View {
    @State private var selectedMember: DivisionMemberResponse?
    @State private var isSheetPresented = false
    @StateObject private var viewModel = DivisionWaitingViewModel()
    let divisionId: Int
    let group: String
    
    var body: some View {
        DodamScrollView.medium(title: "\(group) 그룹\n가입 신청 대기 중인 멤버") {
            VStack(alignment: .leading, spacing: 0) {
                if viewModel.divisionMember?.isEmpty ?? true {
                    Text("대기 중인 멤버가 없습니다.")
                        .body1(.medium)
                        .foreground(DodamColor.Label.assistive)
                        .padding()
                } else {
                    MemberSection(
                        title: "가입 신청 멤버",
                        members: viewModel.divisionMember ?? [],
                        onSelect: showMemberSheet,
                        showDivider: false
                    )
                }
            }
            .padding(16)
        }
        .refreshable {
            await viewModel.fetchAllData(id: divisionId)
        }
        .task {
            await viewModel.fetchAllData(id: divisionId)
        }
        .onChange(of: selectedMember) { newValue in
            isSheetPresented = newValue != nil
        }
        .sheet(isPresented: $isSheetPresented) {
            if let member = selectedMember {
                if #available(iOS 16.4, *) {
                    WaitingMemberSheetView(member: member, id: divisionId)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(dynamicHeight(for: member))])
                } else {
                    WaitingMemberSheetView(member: member, id: divisionId)
                }
            } else {
                Text("멤버 정보를 불러올 수 없습니다.")
            }
        }
        .background(DodamColor.Background.normal)
    }

    private func showMemberSheet(member: DivisionMemberResponse) {
        selectedMember = member
        isSheetPresented = true
    }

    private func dynamicHeight(for member: DivisionMemberResponse) -> CGFloat {
        let baseHeight: CGFloat = 210
        let additionalHeight: CGFloat = CGFloat(member.permission.rawValue.count) * 5
        return min(baseHeight + additionalHeight, 600)
    }
}
