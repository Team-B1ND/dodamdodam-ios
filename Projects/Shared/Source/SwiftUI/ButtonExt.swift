//
//  ButtonExt.swift
//  DodamDodam
//
//  Created by 이민규 on 3/18/24.
//

import SwiftUI
import DDS

public extension Button {
    
    func scaledButtonStyle() -> some View {
        self
            .buttonStyle(ScaledButtonStyle())
    }
    
    struct ScaledButtonStyle: ButtonStyle {
        
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .contentShape(Rectangle())
                .scaleEffect(configuration.isPressed ? 0.96 : 1)
                .background(Color.black.opacity(configuration.isPressed ? 0.05 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .animation(.easeIn(duration: 0.15), value: configuration.isPressed)
        }
    }
}
