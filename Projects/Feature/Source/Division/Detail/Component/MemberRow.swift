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

    init(title: String,
         members: [DivisionMemberResponse],
         onSelect: @escaping (DivisionMemberResponse) -> Void
    ) {
        self.title = title
        self.members = members
        self.onSelect = onSelect
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .body2(.medium)
                .foreground(DodamColor.Label.alternative)
            
            VStack(spacing: 12) {
                ForEach(members.indices, id: \.self) { index in
                    Button {
                        onSelect(members[index])
                    } label: {
                        HStack(spacing: 8) {
                            DodamAvatar.small(url: members[index].profileImage)
                            Text(members[index].memberName)
                                .body1(.medium)
                                .foreground(DodamColor.Label.normal)
                            Spacer()
                            Text(members[index].role.korean)
                                .body2(.medium)
                                .foreground(DodamColor.Label.alternative)
                        }
                        .padding(.vertical, 12)
                    }
                }
            }
        }
    }
}
