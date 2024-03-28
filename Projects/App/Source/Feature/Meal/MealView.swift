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
                        if datas.exists {
                            Text({ () -> String in
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                guard let date = dateFormatter.date(from: datas.date) else {
                                    return "datas.date 가 없습니다"
                                }
                                dateFormatter.locale = Locale(identifier: "ko_KR")
                                dateFormatter.dateFormat = "M월 d일 EEEE"
                                let formattedDate = dateFormatter.string(from: date)
                                return formattedDate
                            }())
                            .font(.title(.small))
                            .dodamColor(.tertiary)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 60)
                            .frame(height: 31)
                            .background(Dodam.color(.secondary))
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                        }
                        VStack(spacing: 12) {
                            ForEach(0..<3, id: \.self) { idx in
                                let data: Meal? = {
                                    switch idx {
                                    case 0: return datas.breakfast
                                    case 1: return datas.lunch
                                    case 2: return datas.dinner
                                    default: return nil
                                    }
                                }()
                                if let data = data {
                                    VStack(spacing: 16) {
                                        HStack(spacing: 12) {
                                            ZStack {
                                                Text({ () -> String in
                                                    switch idx {
                                                    case 0: return "아침"
                                                    case 1: return "점심"
                                                    case 2: return "저녁"
                                                    default: return ""
                                                    }
                                                }())
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
