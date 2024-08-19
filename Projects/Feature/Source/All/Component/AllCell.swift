//
//  AllCell.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/20/24.
//

import SwiftUI
import DDS

public struct AllCell: View {
    
    private let title: String
    private let icon: DodamIconography
    private let action: () -> Void
    
    public init(
        _ title: String,
        icon: DodamIconography,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        self.icon = icon
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    Rectangle()
                        .dodamFill(DodamColor.Fill.alternative)
                        .frame(width: 32, height: 32)
                        .clipShape(.extraSmall)
                    Image(icon: icon)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.vertical, 4)
                .padding(.leading, 8)
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .foreground(DodamColor.Label.normal)
                Spacer()
                Image(icon: .chevronRight)
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foreground(DodamColor.Label.assistive)
                    .padding(.trailing, 4)
            }
        }
        .scaledButtonStyle()
    }
}
