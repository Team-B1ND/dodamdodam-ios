//
//  SugestCell.swift
//  Feature
//
//  Created by dgsw30 on 2/20/25.
//

import SwiftUI
import DDS

struct SugestCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("받은 부원 제안")
                    .font(.headline(.bold))
                    .foreground(DodamColor.Label.normal)
            }
            
            VStack(alignment: .leading, spacing: 14) {
                Text("B1ND")
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
    SugestCell()
}
