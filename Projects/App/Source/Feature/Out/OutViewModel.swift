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
            reason: "reason",
            status: "ALLOWED",
            student: Student(
                id: 1,
                grade: 3,
                room: 4,
                number: 12,
                name: "이민규"
            ),
            startAt: "yyyy-MM-ss HH:mm:ss",
            endAt: "yyyy-MM-ss HH:mm:ss",
            createdAt: "yyyy-MM-ss HH:mm:ss",
            modifiedAt: "yyyy-MM-ss HH:mm:ss"
        ),
        Out(
            id: 2,
            reason: "reason",
            status: "PENDING",
            student: Student(
                id: 1,
                grade: 3,
                room: 4,
                number: 12,
                name: "이민규"
            ),
            startAt: "yyyy-MM-ss HH:mm:ss",
            endAt: "yyyy-MM-ss HH:mm:ss",
            createdAt: "yyyy-MM-ss HH:mm:ss",
            modifiedAt: "yyyy-MM-ss HH:mm:ss"
        )
    ]
    
    @Published var outSleepingData: [Out]?
}
