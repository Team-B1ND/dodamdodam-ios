//
//  MealMenuText.swift
//  DodamDodam
//
//  Created by dgsw8th36 on 9/23/24.
//

import SwiftUI
import DDS

struct MealMenuText: View {
    
    let text: String
    let isMealEmpty: Bool
    
    init(text: String, isMealEmpty: Bool = false) {
        self.text = text
        self.isMealEmpty = isMealEmpty
    }
    
    var body: some View {
        VStack {
            if isMealEmpty {
                Text(text)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foreground(DodamColor.Label.normal)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                Text(text)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.caption)
                    .foreground(DodamColor.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    MealMenuText(text: "test", isMealEmpty: true)
}
