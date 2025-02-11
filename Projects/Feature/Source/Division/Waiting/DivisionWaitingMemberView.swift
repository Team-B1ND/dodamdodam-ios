//
//  DivisionWaitingMemberView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import DDS
import SwiftUI

struct DivisionWaitingMemberView: View {
    @State private var selectedMember: Member?
    @State private var isSheetPresented = false
    @StateObject private var viewModel = DivisionWaitingViewModel()
    let divisionId: Int
    
    var body: some View {
        DodamScrollView.medium(title: "‘B1ND’ 그룹\n가입 신청 대기 중인 멤버") {
            VStack(alignment: .leading, spacing: 0) {
                if viewModel.divisionMember?.isEmpty ?? true {
                    Text("대기 중인 멤버가 없습니다.")
                        .body1(.medium)
                        .foreground(DodamColor.Label.assistive)
                        .padding()
                } else {
                    MemberSection(
                        title: "가입 신청 멤버",
                        members: members,
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
                if #available(iOS 16.0, *) {
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
    
    private var members: [Member] {
        viewModel.divisionMember?.map {
            Member(
                id: $0.id,
                name: $0.memberName,
                role: $0.permission.rawValue,
                imageUrl: $0.profileImage,
                grade: $0.grade,
                room: $0.room,
                number: $0.number
            )
        } ?? []
    }

    private func showMemberSheet(member: Member) {
        selectedMember = member
        isSheetPresented = true
    }

    private func dynamicHeight(for member: Member) -> CGFloat {
        let baseHeight: CGFloat = 210
        let additionalHeight: CGFloat = CGFloat(member.role?.count ?? 0) * 5
        return min(baseHeight + additionalHeight, 600)
    }
}
