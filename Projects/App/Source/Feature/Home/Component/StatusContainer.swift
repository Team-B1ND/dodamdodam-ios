//
//  StatusContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

struct StatusContainer: View {

    let status: String
    var isPending: Bool {
        status == "PENDING"
    }

    init(
        status: String
    ) {
        self.status = status
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            DodamCircularProgressView(progress: 0.7, isDisabled: isPending)
            VStack(alignment: .leading, spacing: 4) {
                Text(isPending ? "대기 중" : "13시간")
                    .font(.dodamBody2)
                    .foregroundStyle(Color(.onSurfaceVariant))
                if !isPending {
                    Text("남음")
                        .font(.dodamLabel2)
                        .foregroundStyle(Color(.tertiary))
                }
                Text("13:00 복귀")
                    .font(.dodamLabel2)
                    .foregroundStyle(Color(.tertiary))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
