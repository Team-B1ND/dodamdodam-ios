//
//  WakeupSongCell.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

struct WakeupSongCell: View {
    
    var body: some View {
        HStack(spacing: 16) {
            Image(.onboard)
                .resizable()
                .aspectRatio(16 / 9, contentMode: .fill)
                .frame(width: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.vertical, 8)
            VStack(alignment: .leading, spacing: 2) {
                Text("TWS (투어스) '첫 만남은 계획대로 되")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                Text("HYBE LABELS")
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
                Text("2024.03.18")
                    .font(.label(.small))
                    .dodamColor(.onSurfaceVariant)
            }
            .padding(.vertical, 12)
            Spacer()
        }
    }
}
