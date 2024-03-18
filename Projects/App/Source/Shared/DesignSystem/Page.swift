//
//  Page.swift
//  DodamDodam
//
//  Created by Mercen on 3/18/24.
//

import SwiftUI

public struct DodamPage {
    
    @resultBuilder
    public struct Builder {
        
        public static func buildBlock(
            _ components: DodamPage...
        ) -> [DodamPage] {
            components
        }
    }
    
    public let icon: Image?
    public let content: AnyView
    
    public init<C: View>(
        icon: Image? = nil,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.icon = icon
        self.content = AnyView(content())
    }
}
