//
//  FlowPresenter.swift
//  Shared
//
//  Created by hhhello0507 on 7/28/24.
//

import FlowKit
import SwiftUI

@available(iOS 13, *)
public struct FlowPresenter: View {
    
    private let flow: FlowProvider
    
    public init(flow: FlowProvider) {
        self.flow = flow
    }
    
    public var body: some View {
        flow.present()
            .environmentObject(flow)
    }
}
