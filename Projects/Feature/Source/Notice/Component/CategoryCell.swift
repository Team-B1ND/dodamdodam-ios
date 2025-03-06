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
    @Binding var selectedCategory: Int?
    let categories: [(id: Int?, name: String)]
    let onSelectCategory: (Int?) -> Void

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(categories, id: \.id) { category in
                        CategoryButton(
                            category.name,
                            isSelected: selectedCategory == category.id
                        ) {
                            selectedCategory = category.id
                            onSelectCategory(category.id)
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
