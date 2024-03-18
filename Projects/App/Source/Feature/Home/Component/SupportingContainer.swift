//
//  SupportingContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

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
                .font(.dodamLabel2)
                .foregroundStyle(Color(.tertiary))
            Text(title)
                .font(.dodamTitle3)
                .foregroundStyle(Color(.primary))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
