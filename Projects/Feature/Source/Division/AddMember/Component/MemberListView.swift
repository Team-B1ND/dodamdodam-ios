//
//  MemberListView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/6/25.
//

import DDS
import SwiftUI
import Domain

struct MemberListView: View {
    @Binding var selectedMembers: [Int: Bool]
    var members: [DivisionMemberResponse]

    var allSelected: Bool {
        members.allSatisfy { selectedMembers[$0.id, default: false] }
    }

    var body: some View {
        VStack(spacing: 12) {
            Button {
                let newValue = !allSelected
                for member in members {
                    selectedMembers[member.id] = newValue
                }
            } label: {
                HStack(spacing: 8) {
                    Image(icon: allSelected ? .checkCircle : .checkmarkCircle)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foreground(allSelected ? DodamColor.Primary.normal : DodamColor.Label.assistive)
                    
                    Text("전체")
                        .body1(.bold)
                        .foreground(DodamColor.Label.normal)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(members, id: \.id) { member in
                HStack(spacing: 8) {
                    DodamAvatar.small(url: member.profileImage)
                    Text(member.memberName)
                        .body1(.medium)
                        .foreground(DodamColor.Label.normal)
                    Spacer()
                    Button {
                        selectedMembers[member.id] = !(selectedMembers[member.id] ?? false)
                    } label: {
                        Image(icon: selectedMembers[member.id, default: false] ? .checkCircle : .noneCheckCircle)
                            .resizable()
                            .foreground(selectedMembers[member.id, default: false] ? DodamColor.Primary.normal : DodamColor.Label.assistive)
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 8)
            }
        }
    }
}
