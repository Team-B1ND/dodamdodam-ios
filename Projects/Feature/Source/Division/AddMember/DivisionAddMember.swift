//
//  File.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import DDS
import SwiftUI
import FlowKit

struct DivisionAddMember: View {
    @Flow var flow
    @State var member: String = ""
    
    @State private var selectedMembers: [String: (Bool, String?)] = [
        "test": (false, nil)
    ]
    
    var allSelected: Bool {
        selectedMembers.values.allSatisfy { $0.0 }
    }

    var body: some View {
            VStack {
                Button {
                    flow.push(DvisionDetailView(), animated: false)
                } label: {
                    HStack {
                        Image(icon: .arrowLeft)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foreground(DodamColor.Label.normal)
                            .padding(12)
                        
                        Text("멤버 추가")
                            .headline(.bold)
                            .foreground(DodamColor.Label.normal)
                        
                        Spacer()
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        DodamTextField.default(
                            title: "멤버 검색",
                            text: $member
                        )
                        
                        CustomAccordion(
                            title: "2학년 4반",
                            content: {
                                MemberListView(selectedMembers: $selectedMembers)
                            }
                        )
                    }
                    .padding(.horizontal, 16)
                }
                .frame(maxHeight: .infinity)
                
                HStack {
                    Button {
                        for key in selectedMembers.keys {
                            selectedMembers[key]?.0 = false
                        }
                    } label: {
                        Text("전체 취소")
                            .body2(.bold)
                            .foreground(DodamColor.Label.neutral)
                            .frame(width: 124, height: 48)
                            .background(DodamColor.Fill.normal)
                            .cornerRadius(12)
                    }
                    .padding(.trailing, 8)
                    
                    Button {
                    } label: {
                        Text("추가")
                            .body2(.bold)
                            .foreground(DodamColor.Static.white)
                            .frame(width: 248, height: 48)
                            .background(DodamColor.Primary.normal)
                            .cornerRadius(12)
                    }
                }
                .padding(.top, 55)
                .padding(.bottom, 12)
            }
            .background(DodamColor.Background.neutral)
            .padding(.horizontal, 16)
    }
}
