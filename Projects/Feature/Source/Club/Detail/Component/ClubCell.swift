//
//  ClubCell.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import SwiftUI
import DDS
import Domain
import CachedAsyncImage

extension StateType {
    var tag: StateTypeTag? {
        switch self {
                case .allowed:
                    return StateTypeTag(title: "승인됨", type: .primary)
                case .waiting, .pending:
                    return StateTypeTag(title: "대기중", type: .secondary)
                case .rejected:
                    return StateTypeTag(title: "거절됨", type: .negative)
                case .deleted:
                    return nil
                }
    }
}

struct ClubCell: View {
    private let data: ClubsResponse
    private let action: () -> Void
    
    init(for data: ClubsResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                CachedAsyncImage(url: URL(string: data.image)) { image in
                    image
                        .resizable()
                        .frame(width: 82, height: 85)
                        .clipShape(.extraSmall)
                } placeholder: {
                    Rectangle()
                        .frame(width: 82, height: 85)
                        .shimmer()
                        .clipShape(.extraSmall)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 3)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(data.subject!)
                        .font(.caption1(.medium))
                        .foreground(DodamColor.Label.alternative)
                    
                    Text(data.name)
                        .font(.heading1(.bold))
                        .foreground(DodamColor.Label.normal)
                    
                    Text(data.shortDescription!)
                        .font(.body2(.medium))
                        .foreground(DodamColor.Label.normal)
                }
                .padding(.bottom, 8)
                
                Spacer()

                                data.state.tag
                                    .padding(.horizontal)
            }
            .padding(.vertical, 2)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
