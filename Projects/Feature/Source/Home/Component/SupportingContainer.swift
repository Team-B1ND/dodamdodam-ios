//
//  SupportingContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

struct SupportingContainer: View {
    
    private let subTitle: String
    private let title: String
    
    init(
        subTitle: String,
        title: String
    ) {
        self.subTitle = subTitle
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(subTitle)
                .caption1(.medium)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .foreground(DodamColor.Label.alternative)
            Text(title)
                .body1(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .foreground(DodamColor.Primary.normal)
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
