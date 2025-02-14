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
        VStack {
            HStack {
                Button(action: {
                    let newValue = !allSelected
                    for member in members {
                        selectedMembers[member.id] = newValue
                    }
                }) {
                    Image(icon: allSelected ? .checkCircle : .checkmarkCircle)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foreground(allSelected ? DodamColor.Primary.normal : DodamColor.Label.assistive)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 8)
                
                Text("전체")
                    .body1(.bold)
                    .foreground(DodamColor.Label.normal)
                
                Spacer()
            }
            .padding(.bottom, 8)

            ForEach(members, id: \.id) { member in
                HStack {
                    DodamAvatar.small(url: member.profileImage)
                    Text(member.memberName)
                        .body1(.medium)
                        .foreground(DodamColor.Label.normal)
                        .padding(.leading, 8)
                    Spacer()
                    Button(action: {
                        selectedMembers[member.id] = !(selectedMembers[member.id] ?? false)
                    }) {
                        Image(icon: selectedMembers[member.id, default: false] ? .checkCircle : .noneCheckCircle)
                            .resizable()
                            .foreground(selectedMembers[member.id, default: false] ? DodamColor.Primary.normal : DodamColor.Label.assistive)
                            .frame(width: 24, height: 24)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 8)
            }
        }
        .padding(.vertical, 12)
    }
}
