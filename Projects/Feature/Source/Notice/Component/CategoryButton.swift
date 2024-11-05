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
    private let type: CategoryType
    
    init(
       _ title: String,
        type: CategoryType = .normal
    ) {
        self.title = title
        self.type = type
    }
    
    public var body: some View {
            Text(title)
                .font(.label(.medium))
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                .foreground(type == .normal ? DodamColor.Label.alternative : DodamColor.Static.white)
                .background(type == .normal ? DodamColor.Background.normal : DodamColor.Primary.normal)
                .cornerRadius(30)
                .overlay(
                    Group{
                        if type == .normal {
                            RoundedRectangle(cornerRadius: 30)
                                .dodamStroke(DodamColor.Line.alternative, lineWidth: 1)
                        }
                    }
                 )
    }
}
