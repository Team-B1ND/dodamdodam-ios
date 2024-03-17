//
//  SupportingButton.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

struct SupportingButton: View {
    
    let title: String
    let subTitle: String
    
    init(
        title: String,
        subTitle: String
    ) {
        self.title = title
        self.subTitle = subTitle
    }

    var body: some View {
        Button {
            // navigation to next view
        } label: {
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
}
