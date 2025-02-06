//
//  MemberListView.swift
//  Feature
//
//  Created by dgsw8th61 on 2/6/25.
//

import DDS
import SwiftUI

struct MemberListView: View {
    @Binding var selectedMembers: [String: (Bool, String?)]

    var allSelected: Bool {
        selectedMembers.values.allSatisfy { $0.0 }
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    let newValue = !allSelected
                    for key in selectedMembers.keys {
                        selectedMembers[key]?.0 = newValue
                    }
                }) {
                    Image(icon: allSelected ? .checkCircle : .checkmarkCircle)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foreground(allSelected ? DodamColor.Primary.normal : DodamColor.Label.assistive)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 8)
                
                Text("전체")
                    .body1(.bold)
                    .foreground(DodamColor.Label.normal)
                
                Spacer()
            }
            .padding(.bottom, 8)
            
            ForEach(selectedMembers.keys.sorted(), id: \.self) { name in
                HStack {
                    DodamAvatar.small(url: selectedMembers[name]?.1)
                    Text(name)
                        .body1(.medium)
                        .foreground(DodamColor.Label.normal)
                        .padding(.leading, 8)
                    Spacer()
                    Button(action: {
                        selectedMembers[name]?.0.toggle()
                    }) {
                        Image(icon: selectedMembers[name]?.0 == true ? .checkCircle : .checkmarkCircle)
                            .resizable()
                            .foreground(selectedMembers[name]?.0 == true ? DodamColor.Primary.normal : DodamColor.Label.assistive)
                            .frame(width: 24, height: 24)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.vertical, 8)
            }
        }
        .padding(.vertical, 12)
    }
}
