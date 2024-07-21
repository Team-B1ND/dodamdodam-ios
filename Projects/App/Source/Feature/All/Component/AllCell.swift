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
                        .dodamFill(.secondary)
                        .frame(width: 32, height: 32)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Image(icon: icon)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.vertical, 4)
                .padding(.leading, 8)
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .dodamColor(.onBackground)
                Spacer()
                Image(icon: .chevronRight)
                    .resizable()
                    .frame(width: 14, height: 14)
                    .dodamColor(.onSurfaceVariant)
                    .padding(.trailing, 4)
            }
        }
        .scaledButtonStyle()
    }
}
