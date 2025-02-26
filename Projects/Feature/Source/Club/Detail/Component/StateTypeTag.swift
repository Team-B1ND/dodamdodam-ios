//
//  StateTypeCell.swift
//  Feature
//
//  Created by dgsw30 on 2/26/25.
//

import SwiftUI
import DDS

struct StateTypeTag: View {
    enum TagType {
        case primary
        case secondary
        case negative
        
        var color: DodamColorable {
            switch self {
            case .primary: DodamColor.Primary.normal
            case .secondary: DodamColor.Line.normal
            case .negative:  DodamColor.Status.negative
            }
        }
    }
    private let title: String
    private let type: TagType
    
    init(title: String, type: TagType) {
        self.title = title
        self.type = type
    }
    
    var body: some View {
        Text(title)
            .font(.caption2(.bold))
            .foreground(DodamColor.Static.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(type.color)
            .clipShape(.extraSmall)
    }
}
