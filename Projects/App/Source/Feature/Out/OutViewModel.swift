//
//  OutViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import Combine

class OutViewModel: ObservableObject {
    
    @Published var selection: Int = 0
    @Published var outGoingData: [Out]? = [
        Out(
            id: 1,
            reason: "이유 없음",
            status: "ALLOWED",
            student: Student(
                id: 1,
                grade: 3,
                room: 4,
                number: 12,
                name: "규민이"
            ),
            startAt: "2024-03-24 17:00:00",
            endAt: "2024-03-26 12:00:00",
            createdAt: "2024-03-23 17:00:00",
            modifiedAt: "2024-03-23 17:00:00"
        ),
        Out(
            id: 2,
            reason: "아무 이유나 적기",
            status: "DENY",
            student: Student(
                id: 1,
                grade: 3,
                room: 4,
                number: 12,
                name: "이민규"
            ),
            startAt: "2024-03-24 17:00:00",
            endAt: "2024-03-26 12:00:00",
            createdAt: "2024-03-23 17:00:00",
            modifiedAt: "2024-03-23 17:00:00"
        )
    ]
    
    @Published var outSleepingData: [Out]?
}
