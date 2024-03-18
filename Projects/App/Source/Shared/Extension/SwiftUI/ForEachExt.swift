//
//  ForEachExt.swift
//  DodamDodam
//
//  Created by 이민규 on 3/18/24.
//

import SwiftUI

extension ForEach: DodamPageConvertible where Content == DodamPage {
    
    public var items: [DodamPage] {
        data.map(content)
    }
}
