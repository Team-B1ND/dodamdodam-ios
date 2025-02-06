//
//  DvisionDetailView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/4/25.
//

import SwiftUI
import DDS
import FlowKit

struct DvisionDetailView: View {
    @State private var selectedMember: Member?
    @State private var isSheetPresented = false
    @Flow var flow

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("B1ND")
                            .heading1(.bold)
                            .foreground(DodamColor.Label.normal)
                        Spacer()
                        
                        Image(icon: .menu)
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foreground(DodamColor.Label.assistive)
                    }
                    .padding(.bottom, 4)
                    
                    Text("바인드는 도담도담도 개발하구요 서버비도 받아야하구요 회식도 해야해구요 존댓말두 써야하구여 도맘도 개발하구요 CMM도 써야하구여")
                        .body1(.medium)
                        .foreground(DodamColor.Label.neutral)
                }
                .padding(16)
                .background(DodamColor.Background.normal)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                HStack {
                    Spacer()
                    Button {
                        flow.push(DivisionWaitingMemberView())
                    } label: {
                        Text("가입 신청")
                            .headline(.bold)
                            .foreground(DodamColor.Label.strong)
                        
                        Text("12")
                            .font(.system(size: 16, weight: .bold))
                            .foreground(DodamColor.Static.white)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 8)
                            .background(DodamColor.Primary.normal)
                            .cornerRadius(30)
                            .padding(.leading, 8)
                    }
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(width: 1, height: 20)
                        .foreground(DodamColor.Line.alternative)
                    Spacer()
                    Button {
                        flow.push(DivisionAddMember())
                    } label: {
                        Text("멤버 추가")
                            .headline(.bold)
                            .foreground(DodamColor.Label.strong)
                    }
                    
                    Spacer()
                }
                .padding(16)
                .background(DodamColor.Background.normal)
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("멤버")
                            .heading1(.bold)
                            .foreground(DodamColor.Label.normal)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    
                    MemberSection(title: "관리자", members: [
                        Member(name: "테스트1", role: "선생님", imageUrl: nil)
                    ], onSelect: showMemberSheet)
                    
                    MemberSection(title: "부관리자", members: [
                        Member(name: "테스트2", role: "학생", imageUrl: nil)

                    ], onSelect: showMemberSheet)
                    
                    MemberSection(title: "멤버", members: [
                        Member(name: "테스트3", role: "학생", imageUrl: nil)
                    ], onSelect: showMemberSheet)
                }
                .padding(16)
                .background(DodamColor.Background.normal)
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
            .background(DodamColor.Background.neutral)
        }
        .sheet(isPresented: $isSheetPresented) {
            if let member = selectedMember {
                if #available(iOS 16.0, *) {
                    MemberDetailSheetView(member: member)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(dynamicHeight(for: member))])
                } else {
                    //
                }
            }
        }
    }

    private func showMemberSheet(member: Member) {
        selectedMember = member
        isSheetPresented = true
    }

    private func dynamicHeight(for member: Member) -> CGFloat {
        let baseHeight: CGFloat = 300
        let additionalHeight: CGFloat = CGFloat(member.role?.count ?? 0) * 5
        return min(baseHeight + additionalHeight, 600)
    }
}
