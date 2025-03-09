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
        VStack(spacing: 16) {
            Button {
                withAnimation(.easeOut(duration: 0.2)) {
                    onToggle()
                }
            } label: {
                HStack {
                    Text(title)
                        .headline(.bold)
                        .foreground(DodamColor.Label.normal)
                    Spacer()
                    Image(icon: isExpanded ? .chevronUp : .chevronDown)
                        .resizable()
                        .renderingMode(.template)
                        .foreground(DodamColor.Label.normal)
                        .frame(width: 18, height: 18)
                        .padding(4)
                }
            }
            
            if isExpanded {
                content
            }
        }
        .padding(16)
        .background(DodamColor.Background.normal)
        .cornerRadius(12)
        .drawingGroup()
    }
}
