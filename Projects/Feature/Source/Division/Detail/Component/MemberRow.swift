//
//  d.swift
//  Feature
//
//  Created by dgsw8th61 on 2/4/25.
//

import SwiftUI
import DDS

struct Member {
    let name: String
    let role: String?
    let imageUrl: String?

    init(name: String, role: String? = nil, imageUrl: String?) {
        self.name = name
        self.role = role
        self.imageUrl = imageUrl
    }
}

struct MemberSection: View {
    let title: String
    let members: [Member]
    let onSelect: (Member) -> Void
    let showDivider: Bool

    init(title: String,
         members: [Member],
         onSelect: @escaping (Member) -> Void,
         showDivider: Bool = true) {
        self.title = title
        self.members = members
        self.onSelect = onSelect
        self.showDivider = showDivider
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .body2(.medium)
                .foreground(DodamColor.Label.alternative)
            
            VStack {
                ForEach(members.indices, id: \.self) { index in
                    Button(action: { onSelect(members[index]) }) {
                        HStack {
                            DodamAvatar.small(url: members[index].imageUrl)
                            Text(members[index].name)
                                .body1(.medium)
                                .foreground(DodamColor.Label.normal)
                                .padding(.leading, 8)
                            Spacer()

                            if let role = members[index].role {
                                Text(role)
                                    .body2(.medium)
                                    .foreground(DodamColor.Label.alternative)
                            }
                        }
                        .padding(.vertical, 12)
                    }
                }
            }
            
            if showDivider {
                DodamDivider(type: .line)
                    .padding(.horizontal, 8)
            }
        }
    }
}
