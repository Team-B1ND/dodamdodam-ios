//
//  DodamWatchView.swift
//  DodamDodam
//
//  Created by 김은찬 on 6/11/25.
//

import SwiftUI
import DDS

struct DodamWatchView: View {
    @StateObject private var viewModel = WatchSessionManager.shared
    
    var body: some View {
        ScrollView {
            VStack {
                Text("오늘의 급식")
                    .body1(.bold)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color("Background"))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(4)
            
            if let meal = viewModel.meal?.first {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(meal.menuList, id: \.self) { item in
                        Text(item)
                    }
                }
                .body1(.medium)
                .foregroundColor(.white)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(6)
                .background(Color("Background"))
                .cornerRadius(10)
                .padding(.horizontal, 4)
            } else {
                Text("급식 정보 없음")
                    .body1(.medium)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
}

#Preview {
    DodamWatchView()
}
