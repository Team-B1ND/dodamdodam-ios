//
//  ViewExt.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func widgetBackground<C: View>(
        @ViewBuilder content: @escaping () -> C
    ) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            containerBackground(for: .widget) {
                content()
            }
        } else {
            background(content())
        }
    }
}
