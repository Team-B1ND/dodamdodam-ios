//
//  CategoryCell.swift
//  Feature
//
//  Created by dgsw8th61 on 11/5/24.
//

import SwiftUI
import DDS
import Shared

enum CategoryType {
    case all
    case normal
}

struct CategoryButton: View {
    private let title: String
    private let isSelected: Bool
    private let action: () -> Void
    
    init(
        _ title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Text(title)
            .font(.label(.medium))
            .padding(.vertical, 8)
            .padding(.horizontal, 18)
            .foreground(isSelected ? DodamColor.Static.white :  DodamColor.Label.alternative)
            .background(isSelected ? DodamColor.Primary.normal : DodamColor.Background.normal)
            .cornerRadius(30)
            .overlay {
                if !isSelected {
                    RoundedRectangle(cornerRadius: 30)
                        .dodamStroke(DodamColor.Line.alternative, lineWidth: 1)
                }
            }
            .onTapGesture {
                action()
            }
    }
}
