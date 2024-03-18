//
//  ViewExt.swift
//  DodamDodam
//
//  Created by Mercen on 3/18/24.
//

import SwiftUI

public extension View {
    
    func page(icon: Image? = nil) -> DodamPage {
        .init(icon: icon) { self }
    }
}
