//
//  CategoryCell.swift
//  Feature
//
//  Created by dgsw8th61 on 11/5/24.
//

import SwiftUI
import DDS
import Domain
import Shared

struct NoticeViewHeader: View {
    @Binding var selectedDivision: DivisionOverviewResponse?
    let divisions: [DivisionOverviewResponse]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    NoticeDivisionCell("전체", isSelected: selectedDivision == nil) {
                        selectedDivision = nil
                    }
                    ForEach(divisions, id: \.id) { division in
                        NoticeDivisionCell(
                            division.name,
                            isSelected: selectedDivision == division
                        ) {
                            selectedDivision = division
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(height: 58)
            DodamDivider()
        }
        .padding(.top, -8)
    }
}
