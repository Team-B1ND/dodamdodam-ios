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
    @State private var selectedCategory: Int? = 0
    
    let categories: [String]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        CategoryButton(
                            categories[index],
                            isSelected: selectedCategory == index
                        ) {
                            selectedCategory = index
                        }
                    }
                }
            }
            .padding(.leading, 16)
            Divider()
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 58)
        .padding(.vertical, 12)
        .background(DodamColor.Background.neutral)
        .padding(.top, -8)
    }
}
