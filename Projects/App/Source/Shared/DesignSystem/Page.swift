//
//  Page.swift
//  DodamDodam
//
//  Created by Mercen on 3/18/24.
//

import SwiftUI

public protocol DodamPageConvertible {
    
    var items: [DodamPage] { get }
}

public struct DodamPage: DodamPageConvertible {
    
    @resultBuilder
    public struct Builder {
        
        public static func buildBlock(
            _ components: DodamPageConvertible...
        ) -> [DodamPageConvertible] {
            components
        }
        
        public static func buildFinalResult(
            _ components: [DodamPageConvertible]
        ) -> [DodamPage] {
            components.flatMap(\.items)
        }
    }
    
    public let icon: Image?
    public let content: AnyView
    
    public var items: [DodamPage] {
        [self]
    }
    
    public init<C: View>(
        icon: Image? = nil,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.icon = icon
        self.content = AnyView(content())
    }
}

extension DodamPage: View {
    
    public var body: Never {
        fatalError()
    }
}
