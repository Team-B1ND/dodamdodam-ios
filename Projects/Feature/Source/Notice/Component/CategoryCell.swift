//
//  CategoryCell.swift
//  Feature
//
//  Created by dgsw8th61 on 11/5/24.
//

import SwiftUI
import DDS
import Shared

struct CategoryCell: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 8) {
                CategoryButton("전체", type: .all)
                ForEach(0..<3, id: \.self) { index in
                    CategoryButton("테스트")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 58)
        .padding(.leading, 16)
        .padding(.vertical,12)
    }
}
