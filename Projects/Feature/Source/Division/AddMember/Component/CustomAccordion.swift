//
//  CustomAccordion.swift
//  Feature
//
//  Created by dgsw8th61 on 2/6/25.
//

import DDS
import SwiftUI

struct CustomAccordion<Content: View>: View {
    let title: String
    let isExpanded: Bool
    let onToggle: () -> Void
    let content: Content
    
    init(title: String, isExpanded: Bool, onToggle: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.title = title
        self.isExpanded = isExpanded
        self.onToggle = onToggle
        self.content = content()
    }

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    onToggle()
                }
            }) {
                HStack {
                    Text(title)
                        .headline(.bold)
                        .foreground(DodamColor.Label.normal)
                    
                    Spacer()
                    Image(icon: isExpanded ? .chevronUp : .chevronDown)
                        .frame(width: 18, height: 18)
                        .foreground(DodamColor.Label.normal)
                }
                .padding(16)
            }
            
            if isExpanded {
                content
                    .transition(.opacity)
                    .padding(.horizontal, 16)
            }
        }
        .background(DodamColor.Background.normal)
        .cornerRadius(12)
    }
}
