//
//  AffiliationCell.swift
//  Feature
//
//  Created by dgsw30 on 2/20/25.
//

import SwiftUI
import DDS

struct AffiliationCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("소속된 동아리")
                    .font(.headline(.bold))
                    .foreground(DodamColor.Label.normal)
            }
            
            VStack(alignment: .leading, spacing: 14) {
                Text("창체")
                    .font(.caption2(.bold))
                    .foreground(DodamColor.Label.alternative)
                HStack {
                    Text("B1ND")
                    Spacer()
//                    DodamTag("입부완료", type: .primary)
                }
                .font(.body2(.medium))
                .foreground(DodamColor.Label.normal)
            }
            .padding(.vertical, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(DodamColor.Background.normal)
        .clipShape(.medium)
        .padding(16)
    }
}

#Preview {
    AffiliationCell()
}
