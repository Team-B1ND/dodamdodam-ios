//
//  NightStudyApplyCell.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS
import Combine

struct NightStudyApplyCell: View {
    
    private let data: NightStudy
    
    public init(
        data: NightStudy
    ) {
        self.data = data
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
                        switch data.status {
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
                    switch data.status {
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
                    if let date = dateFormatter.date(from: data.createdAt) {
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
                Text("\(data.content)")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Dodam.color(.secondary))
                if data.status == "DENIED" {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .font(.label(.large))
                            .dodamColor(.onSurfaceVariant)
                        // 나중에 거절 사유 추가되면 데이터 넣기
                        Text("선생님께서 심자 신청을 거절하였습니다")
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
                                    if let date = dateFormatter.date(from: data.startAt) {
                                        dateFormatter.dateFormat = "M월 d일"
                                        return dateFormatter.string(from: date)
                                    }
                                    return "오류"
                                }())
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                Text("시작")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                                Spacer()
                                Text({ () -> String in
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    dateFormatter.locale = Locale(identifier: "ko_KR")
                                    if let date = dateFormatter.date(from: data.endAt) {
                                        dateFormatter.dateFormat = "M월 d일"
                                        return dateFormatter.string(from: date)
                                    }
                                    return "오류"
                                }())
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                Text("종료")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                            }
                            DodamLinearProgressView(
                                progress: calculatingProgress(
                                    data.startAt,
                                    data.endAt
                                ),
                                isDisabled: data.status == "PENDING" ? true : false
                            )
                        }
                    }
                    HStack(spacing: 8) {
                        Text("휴대폰 사유")
                            .font(.label(.large))
                            .dodamColor(.onSurfaceVariant)
                        Text("\(data.reasonForPhone)")
                            .font(.system(size: 16, weight: .medium))
                            .dodamColor(.onSurface)
                        Spacer()
                    }
                    .padding(.top, 4)
                }
            }
            .padding([.bottom, .horizontal], 16)
        }
        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    let dummyData: NightStudy = NightStudy(
        id: 1,
        content: "도담 개발을 위한 심자 신청",
        status: "DENIED",
        doNeedPhone: true,
        reasonForPhone: "도담도담 iOS 앱을 개발하는데 빌드를 하는 실기기가 필요함",
        student: Student(
            id: 1,
            name: "이민규", 
            grade: 3,
            room: 4,
            number: 12
        ),
        place: "1221호",
        startAt: "2024-04-01 20:00:00",
        endAt: "2024-04-20 20:30:00",
        createdAt: "2024-03-23 17:00:00",
        modifiedAt: "2024-03-23 17:00:00"
    )
    return VStack(spacing: 20) {
        NightStudyApplyCell(data: dummyData)
    }
    .padding(.horizontal, 16)
    .frame(maxHeight: .infinity)
    .background(Dodam.color(.surface))
}
