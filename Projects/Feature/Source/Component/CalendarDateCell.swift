//
//  CalendarCell.swift
//  Feature
//
//  Created by hhhello0507 on 8/12/24.
//

import SwiftUI
import DDS
import Shared

struct CalendarDateCell: View {
    
    private let date: Date?
    private let selected: Bool
    
    init(date: Date?, selected: Bool) {
        self.date = date
        self.selected = selected
    }
    
    private var label: String {
        guard let date else {
            return ""
        }
        guard let day = date[.day] else {
            return ""
        }
        return "\(day)"
    }
    
    var body: some View {
        Text(label)
            .headline(.medium)
            .foreground(
                selected
                ? DodamColor.Static.white
                : DodamColor.Label.alternative
            )
            .padding(.vertical, 8)
            .if(selected) { view in
                view.background {
                    Rectangle()
                        .dodamFill(DodamColor.Primary.normal)
                        .clipShape(.medium)
                        .frame(width: 36, height: 36)
                }
            }
            .frame(maxWidth: .infinity)
            .opacity(date == nil ? 0 : 1)
    }
}
