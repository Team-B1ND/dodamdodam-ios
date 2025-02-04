//
//  DivisionCell.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import DDS
import Domain
import Shared

struct DivisionCell: View {
    private let data: DivisionOverviewResponse
    private let action: () -> Void
    
    init(for data: DivisionOverviewResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(data.name)
                    .foreground(DodamColor.Label.normal)
                    .font(.body1(.medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(icon: .chevronRight)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foreground(DodamColor.Label.assistive)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
        }
        .scaledButtonStyle()
    }
}
