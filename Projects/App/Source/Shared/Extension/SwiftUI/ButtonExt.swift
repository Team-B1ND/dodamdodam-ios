//
//  ButtonExt.swift
//  DodamDodam
//
//  Created by 이민규 on 3/18/24.
//

import SwiftUI
import DDS

extension Button {
    
    func scaledButtonStyle() -> some View {
        self
            .buttonStyle(ScaledButtonStyle())
    }
    
    struct ScaledButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .scaleEffect(configuration.isPressed ? 0.96 : 1)
                .opacity(configuration.isPressed ? 0.8 : 1.0)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .animation(.easeIn(duration: 0.15), value: configuration.isPressed)
        }
    }
}
