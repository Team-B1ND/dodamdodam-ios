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
    
    var body: some View {
        DodamScrollView.medium(title: "‘B1ND’ 그룹\n가입 신청 대기 중인 멤버") {
            VStack(alignment: .leading, spacing: 0) {
                MemberSection(title: "학생", members: [
                    Member(name: "테스트1", imageUrl: nil)
                ], onSelect: showMemberSheet, showDivider: false)
                
                MemberSection(title: "학부모", members: [
                    Member(name: "테스트2", imageUrl: nil)
                ], onSelect: showMemberSheet, showDivider: false)
            }
            .padding(16)
        }
        .sheet(isPresented: $isSheetPresented) {
            if let member = selectedMember {
                if #available(iOS 16.0, *) {
                    WaitingMemberSheetView(member: member)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(dynamicHeight(for: member))])
                } else {
                    //
                }
            }
        }
        .background(DodamColor.Background.normal)
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
