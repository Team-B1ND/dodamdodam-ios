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
    
    func isToday(_ dateStr: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateStr) else {
            return false
        }
        let today = Date()
        return Calendar.current.isDate(date, inSameDayAs: today)
    }
    
    var body: some View {
        DodamScrollView.default(title: "급식") {
            VStack(spacing: 20) {
                if let datas = viewModel.mealData {
                    ForEach({ () -> [MealResponse] in
                        datas.filter {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            guard let date = dateFormatter.date(from: $0.date) else {
                                return false
                            }
                            let today = Calendar.current.startOfDay(for: Date())
                            return $0.exists && date >= today
                        }
                    }(), id: \.self) { datas in
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
                        .font(.body(.medium))
                        .dodamColor(
                            isToday(datas.date) ? .onPrimary : .onSecondaryContainer
                        )
                        .padding(.vertical, 4)
                        .frame(width: 218, height: 31)
                        .background(
                            isToday(datas.date)
                            ? Dodam.color(.primary).opacity(0.65)
                            : Dodam.color(.secondaryContainer)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        
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
                                                .font(.body(.medium))
                                                .dodamColor(.onPrimary)
                                            }
                                            .frame(width: 52, height: 27)
                                            .background(Dodam.color(.primary))
                                            .clipShape(RoundedRectangle(cornerRadius: 32))
                                            Spacer()
                                            Text("\(Int(data.calorie))Kcal")
                                                .font(.label(.large))
                                                .dodamColor(.onSurfaceVariant)
                                                .padding(.top, 5)
                                        }
                                        .padding([.top, .horizontal], 16)
                                        Text(data.details.map { $0.name }.joined(separator: "\n"))
                                            .font(.body(.medium))
                                            .dodamColor(.onSurface)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding([.bottom, .horizontal], 16)
                                    }
                                    .background(Dodam.color(.surfaceContainer))
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                }
                            }
                        }
                    }
                } else {
                    Text("이번 달 급식이 없어요")
                        .font(.system(size: 16, weight: .medium))
                        .dodamColor(.tertiary)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 16)
        }
        .bottomMask()
        .background(Dodam.color(.surface))
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    MealView()
}
