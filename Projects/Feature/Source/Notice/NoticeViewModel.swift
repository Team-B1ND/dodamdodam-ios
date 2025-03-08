//
//  NoticeViewModel.swift
//  Feature
//
//  Created by dgsw8th61 on 2/13/25.
//

import Foundation
import DIContainer
import Domain
import Shared
import Combine

let dummyNotices: [NoticeResponse] = [
    .init(
        id: 1,
        title: "title",
        content: "contnet https://forms.gle/wfp1fRNNfcr11RcHA",
        noticeStatus: .created,
        noticeFileRes: [
            .init(
                fileUrl: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s")!,
                fileName: "image",
                fileType: .image
            )
        ],
        memberInfoRes: .init(
            id: "id",
            name: "name",
            email: "e",
            role: .student,
            status: .active,
            profileImage: nil,
            phone: "",
            student: nil,
            teacher: nil,
            createdAt: .now,
            modifiedAt: .now
        ),
        createdAt: .now,
        modifiedAt: .now
    )
]

final class NoticeViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    // MARK: - State
    @Published var notices: [NoticeResponse]?
    @Published var myDivisions: [DivisionOverviewResponse]?
    @Published var selectedDivision: DivisionOverviewResponse?
    var isFirstOnAppear: Bool = true

    // MARK: - Repository
    @Inject private var noticeRepository: NoticeRepository
    @Inject private var divisionRepository: DivisionRepository

    // MARK: - Method
    init() {
        $selectedDivision.sink { [self] _ in
            notices = nil
            Task {
                await fetchNotices()
            }
        }
        .store(in: &subscription)
    }
    
    @MainActor
    func clearData() {
        notices = nil
        myDivisions = nil
        selectedDivision = nil
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    @MainActor
    func fetchNotices(lastId: Int? = nil) async {
        do {
            let response = try await noticeRepository.fetchNoticeByDivision(
                .init(lastId: lastId, id: selectedDivision?.id, limit: NoticeView.pagingInterval)
            )
            if lastId == nil {
                notices = response
            } else {
                notices?.append(contentsOf: response)
            }
        } catch {
            print(error)
        }
    }

    @MainActor
    func fetchMyDivisions() async {
        do {
            myDivisions = try await divisionRepository.fetchMyDivision(
                .init(lastId: 0, limit: NoticeView.pagingInterval, keyword: "")
            )
        } catch {
            print(error)
        }
    }
}

extension NoticeViewModel: OnAppearProtocol {
    
    @MainActor
    func fetchAllData() async {
        async let fetchNotices: () = fetchNotices()
        async let fetchMyDivisions: () = fetchMyDivisions()
        _ = await [fetchNotices, fetchMyDivisions]
    }
}
