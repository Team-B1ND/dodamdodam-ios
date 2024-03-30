//
//  OutApplyCell.swift
//  DodamDodam
//
//  Created by 이민규 on 3/23/24.
//

import SwiftUI
import DDS
import Combine

struct OutApplyCell: View {
    
    public enum OutType {
        case outGoing, outSleeping
    }
    
    private let outData: OutResponse
    private let outType: OutType
    
    public init(
        data outData: OutResponse,
        outType: OutType
    ) {
        self.outData = outData
        self.outType = outType
    }
    
    func calculatingProgress(
        _ startAt: String,
        _ endAt: String
    ) -> Double {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let startDate = dateFormatter.date(from: startAt),
              let endDate = dateFormatter.date(from: endAt) else {
            return 0.0
        }
        let totalDuration = endDate.timeIntervalSince(startDate)
        
        print("currentDate : \(currentDate)")
        print("startDate : \(startDate)")
        print("endDate : \(endDate)")
        if currentDate < startDate {
            return 0.0
        } else if currentDate >= endDate {
            return 1.0
        } else {
            let elapsedTime = currentDate.timeIntervalSince(startDate)
            let progress = elapsedTime / totalDuration
            return progress
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    Text({ () -> String in
                        switch outData.status.rawValue {
                        case "ALLOWED": return "승인됨"
                        case "PENDING": return "대기중"
                        case "DENIED": return "거절됨"
                        default: return ""
                        }
                    }())
                    .font(.title(.small))
                    .dodamColor(.onPrimary)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                }
                .frame(height: 27)
                .background({ () -> Color in
                    switch outData.status.rawValue {
                    case "ALLOWED": return Dodam.color(.primary)
                    case "PENDING": return Dodam.color(.onSurfaceVariant)
                    case "DENIED": return Dodam.color(.error)
                    default: return Dodam.color(.primary)
                    }
                }())
                .clipShape(RoundedRectangle(cornerRadius: 32))
                Spacer()
                Text({ () -> String in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.locale = Locale(identifier: "ko_KR")
                    if let date = dateFormatter.date(from: outData.createdAt) {
                        dateFormatter.dateFormat = "M월 d일 (E)"
                        return dateFormatter.string(from: date)
                    }
                    return "오류"
                }())
                .font(.label(.large))
                .dodamColor(.onSurfaceVariant)
                .padding(.top, 5)
            }
            .padding([.top, .horizontal], 16)
            VStack(spacing: 12) {
                Text("\(outData.reason)")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Dodam.color(.secondary))
                if outData.status.rawValue == "DENIED" {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .font(.label(.large))
                            .dodamColor(.onSurfaceVariant)
                        // 나중에 거절 사유 추가되면 데이터 넣기
                        Text("선생님께서 외출을 거절하였습니다")
                            .font(.system(size: 16, weight: .medium))
                            .dodamColor(.onSurface)
                        Spacer()
                    }
                    .padding(.top, 4)
                } else {
                    HStack(alignment: .bottom, spacing: 16) {
                        VStack(spacing: 8) {
                            HStack(alignment: .bottom, spacing: 4) {
                                Text({ () -> String in
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    dateFormatter.locale = Locale(identifier: "ko_KR")
                                    if let date = dateFormatter.date(from: outData.startAt) {
                                        dateFormatter.dateFormat = outType == .outGoing ? "M월 d일" : "HH시 mm분"
                                        return dateFormatter.string(from: date)
                                    }
                                    return "오류"
                                }())
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                Text(outType == .outGoing ? "외출" : "외박")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                                Spacer()
                                Text({ () -> String in
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    dateFormatter.locale = Locale(identifier: "ko_KR")
                                    if let date = dateFormatter.date(from: outData.endAt) {
                                        dateFormatter.dateFormat = outType == .outGoing ? "M월 d일" : "HH시 mm분"
                                        return dateFormatter.string(from: date)
                                    }
                                    return "오류"
                                }())
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                Text("복귀")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                            }
                            DodamLinearProgressView(
                                progress: calculatingProgress(
                                    outData.startAt,
                                    outData.endAt
                                ),
                                isDisabled: outData.status.rawValue == "PENDING" ? true : false
                            )
                        }
                    }
                }
            }
            .padding([.bottom, .horizontal], 16)
        }
        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
