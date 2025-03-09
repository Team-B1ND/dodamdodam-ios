//
//  WaitingMemberSheetView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import DDS
import SwiftUI
import Domain

struct WaitingMemberSheetView: View {
    let member: DivisionMemberResponse
    let id: Int
    @ObservedObject var viewModel: DivisionWaitingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(member.memberName)님 정보")
                .heading1(.bold)
                .foreground(DodamColor.Label.normal)
            
            Text("직군 | \(member.role.korean)")
                .headline(.medium)
                .foreground(DodamColor.Label.assistive)
                .padding(.top, 8)
            if let grade = member.grade, let room = member.room, let number = member.number {
                Text("학번 | \(grade)학년 \(room)반 \(number)번")
                    .headline(.medium)
                    .foreground(DodamColor.Label.assistive)
                    .padding(.top, 8)
            }
            
            HStack(spacing: 8) {
                DodamButton.fullWidth(
                    title: "거절하기"
                ) {
                    await viewModel.deleteMembers(id: id, idList: [member.id])
                }
                .role(.assistive)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
                
                DodamButton.fullWidth(
                    title: "승인하기"
                ) {
                    await viewModel.addMembers(id: id, memberId: [member.memberId])
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .padding(.top, 37)
        .padding(.horizontal, 16)
    }
}
