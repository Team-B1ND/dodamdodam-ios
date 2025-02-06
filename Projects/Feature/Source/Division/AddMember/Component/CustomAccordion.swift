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
    let content: Content
    
    @State private var isExpanded: Bool = false
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            })
            {
                HStack {
                    Text(title)
                        .headline(.bold)
                        .foreground(DodamColor.Label.normal)
                    
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
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
