//
//  d.swift
//  Feature
//
//  Created by dgsw8th61 on 2/4/25.
//

import SwiftUI
import DDS
import Domain

struct MemberSection: View {
    let title: String
    let members: [DivisionMemberResponse]
    let onSelect: (DivisionMemberResponse) -> Void
    let showDivider: Bool

    init(title: String,
         members: [DivisionMemberResponse],
         onSelect: @escaping (DivisionMemberResponse) -> Void,
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
                            DodamAvatar.small(url: members[index].profileImage)
                            Text(members[index].memberName)
                                .body1(.medium)
                                .foreground(DodamColor.Label.normal)
                                .padding(.leading, 8)
                            Spacer()

                            Text(members[index].permission.rawValue)
                                .body2(.medium)
                                .foreground(DodamColor.Label.alternative)
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
