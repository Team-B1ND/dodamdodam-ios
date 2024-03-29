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
    
    public init(
        subTitle: String,
        title: String
    ) {
        self.subTitle = subTitle
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(subTitle)
                .font(.label(.large))
                .dodamColor(.onSurfaceVariant)
            Text(title)
                .font(.body(.large))
                .dodamColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
