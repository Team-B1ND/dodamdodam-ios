//
//  ButtonExt.swift
//  DodamDodam
//
//  Created by 이민규 on 3/18/24.
//

import SwiftUI

extension Button {
    
    func scaledButtonStyle() -> some View {
        self
            .buttonStyle(ScaledButtonStyle())
    }
    
    struct ScaledButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .scaleEffect(configuration.isPressed ? 0.96 : 1)
                .background(configuration.isPressed ? Color(.secondary).opacity(0.5) : .white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .animation(.easeIn(duration: 0.15), value: configuration.isPressed)
        }
    }
}
