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
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    Rectangle()
                        .frame(width: 82, height: 85)
                        .shimmer()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 3)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(data.subject)
                        .font(.caption1(.medium))
                        .foreground(DodamColor.Label.alternative)
                    
                    Text(data.name)
                        .font(.heading1(.bold))
                        .foreground(DodamColor.Label.normal)
                    
                    Text(data.shortDescription)
                        .font(.body2(.medium))
                        .foreground(DodamColor.Label.normal)
                }
                .padding(.bottom, 8)
            }
            .padding(.vertical, 2)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
