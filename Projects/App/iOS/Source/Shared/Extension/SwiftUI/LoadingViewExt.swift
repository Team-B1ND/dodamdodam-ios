//
//  LoadingViewExt.swift
//  DodamDodam
//
//  Created by Mercen on 4/5/24.
//

import SwiftUI
import DDS

extension DodamLoadingView {
    
    @ViewBuilder
    static func conditional<C: View>(
        _ condition: Bool,
        @ViewBuilder content: @escaping () -> C
    ) -> some View {
        if condition {
            content()
        } else {
            DodamLoadingView()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
        }
    }
}
