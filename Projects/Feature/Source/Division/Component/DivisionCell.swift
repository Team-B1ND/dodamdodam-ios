//
//  DivisionCell.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import DDS

struct DivisionCell: View {
    private let name: String
    private let action: () -> Void
    
    init(name: String, action: @escaping () -> Void) {
        self.name = name
        self.action = action
    }
    
    var body: some View {
        HStack {
            Text(name)
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
}
