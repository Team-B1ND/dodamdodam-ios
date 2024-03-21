//
//  MealView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import SwiftUI
import DDS

struct MealView: View {
    
    @InjectObject var viewModel: MealViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView {
            Text("급식")
                .font(.headline(.large))
                .dodamColor(.onBackground)
                .padding(.leading, 20)
            Spacer()
        } content: {
            VStack(spacing: 20) {
                if let mealDatas = viewModel.mealDatas {
                    ForEach(mealDatas, id: \.self) { datas in
                        Text("\(datas.date)")
                            .font(.title(.small))
                            .dodamColor(.tertiary)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 60)
                            .frame(height: 31)
                            .background(Dodam.color(.secondary))
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                        VStack(spacing: 12) {
                            ForEach([
                                datas.breakfast,
                                datas.lunch,
                                datas.dinner
                            ], id: \.self) { data in
                                VStack(spacing: 16) {
                                    HStack(spacing: 12) {
                                        ZStack {
                                            Text("title")
                                                .font(.title(.small))
                                                .dodamColor(.onPrimary)
                                                .padding(.vertical, 4)
                                                .padding(.horizontal, 12)
                                        }
                                        .frame(height: 27)
                                        .background(Dodam.color(.primary))
                                        .clipShape(RoundedRectangle(cornerRadius: 32))
                                        Spacer()
                                        Text("\(Int(data.calorie))Kcal")
                                            .font(.label(.large))
                                            .dodamColor(.tertiary)
                                            .padding(.top, 5)
                                    }
                                    .padding([.top, .horizontal], 16)
                                    Text(data.details.map { $0.name }.joined(separator: "\n"))
                                        .font(.body(.medium))
                                        .dodamColor(.onBackground)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.bottom, .horizontal], 16)
                                }
                                .background(Dodam.color(.surfaceContainer))
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 58)
            .padding(.bottom, 150)
        }
    }
}

#Preview {
    MealView()
}
