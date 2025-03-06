//
//  ApplyCell.swift
//  Feature
//
//  Created by dgsw30 on 2/20/25.
//

import SwiftUI
import DDS

struct MyApplyCell: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("내신청")
                    .font(.headline(.bold))
                    .foreground(DodamColor.Label.normal)
            }
            
            VStack(alignment: .leading, spacing: 14) {
                Text("창체")
                    .font(.caption2(.bold))
                    .foreground(DodamColor.Label.alternative)
                
                HStack {
                    Text("1지망")
                    Spacer()
                    Text("B1ND")
                }
                .font(.body2(.medium))
                .foreground(DodamColor.Label.normal)
                
                HStack {
                    Text("2지망")
                    Spacer()
                    Text("ALT")
                }
                .font(.body2(.medium))
                .foreground(DodamColor.Label.normal)
                
                HStack {
                    Text("3지망")
                    Spacer()
                    Text("두카미")
                }
                .font(.body2(.medium))
                .foreground(DodamColor.Label.normal)
            }
            .padding(.vertical, 16)
            
            VStack(alignment: .leading, spacing: 14) {
                Text("자율")
                    .font(.caption2(.bold))
                    .foreground(DodamColor.Label.alternative)
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("자탄학")
                    Text("IND")
                    Text("Draw")
                }
                .font(.body2(.medium))
                .foreground(DodamColor.Label.normal)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(DodamColor.Background.normal)
        .clipShape(.medium)
        .padding(16)
    }
}

#Preview {
    MyApplyCell()
}
