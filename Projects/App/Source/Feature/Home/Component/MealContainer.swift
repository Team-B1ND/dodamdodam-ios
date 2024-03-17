//
//  MealContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

struct MealContainer: View {
    
    var body: some View {
        // UI test ( 임시 코드 )
        VStack(alignment: .trailing, spacing: 0) {
            Text("쇠고기우엉볶음밥, 불고기치즈파니니, 계란실파국, 오이생채, 배추김치")
                .font(.dodamBody2)
                .foregroundStyle(Color(.onSurfaceVariant))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 5) {
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundStyle(Color(.primary))
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundStyle(Color(.secondary))
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundStyle(Color(.secondary))
            }
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    MealContainer()
}
