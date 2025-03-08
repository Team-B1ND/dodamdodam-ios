//
//  File.swift
//  Feature
//
//  Created by dgsw8th61 on 2/5/25.
//

import DDS
import SwiftUI
import FlowKit
import Domain
import Shared

// memberSearchText:
// 추후 서버 구현. 마감 때문에 우선순위 미룸
struct DivisionAddMember: View {
    @Flow var flow
//    @State var memberSearchText: String = ""
    @StateObject private var viewModel = AddMemberViewModel()
    
    @State private var selectedMembers: [Int: [Int: Bool]] = [:]
    @State private var expandedDivisionId: Set<Int> = []
    @State private var controlButtonsSize: CGSize = .zero
    let id: Int
    
//    var filteredDivisions: [DivisionOverviewResponse] {
//        if memberSearchText.isEmpty {
//            return viewModel.divisions ?? []
//        } else {
//            return viewModel.divisions?.filter { division in
//                let members = viewModel.divisionMembers[division.id] ?? []
//                return members.contains { $0.memberName.localizedCaseInsensitiveContains(memberSearchText) }
//            } ?? []
//        }
//    }
    
    var body: some View {
        DodamScrollView.small(title: "멤버 추가") {
            VStack(spacing: 12) {
//                DodamTextField.default(
//                    title: "멤버 검색",
//                    text: $memberSearchText
//                )
                
                if let divisions = viewModel.divisions {
                    divisionListView(divisions)
                } else {
                    DodamLoadingView()
                        .padding(.vertical, 40)
                }
            }
            .padding(.horizontal, 16)
        }
        .background(DodamColor.Background.neutral)
        .safeAreaInset(edge: .bottom) {
            controlButtons
        }
        .task {
            await viewModel.fetchDivisions()
        }
    }
    
    @ViewBuilder
    private func divisionListView(_ divisions: [DivisionOverviewResponse]) -> some View {
        ForEach(divisions, id: \.id) { division in
            let divisionId = division.id
            let isExpanded = expandedDivisionId.contains(divisionId)
            
            CustomAccordion(
                title: division.name,
                isExpanded: isExpanded,
                onToggle: {
                    toggleAccordion(for: divisionId)
                    Task {
                        await viewModel.fetchDivisionMembers(divisionId: divisionId)
                    }
                }
            ) {
                if let members = viewModel.divisionMembers[divisionId] {
                    MemberListView(
                        selectedMembers: Binding(
                            get: { selectedMembers[divisionId, default: [:]] },
                            set: { selectedMembers[divisionId] = $0 }
                        ),
                        members: members
                    )
                } else {
                    DodamLoadingView()
                        .padding(.vertical, 10)
                }
            }
            .task {
                if let index = divisions.firstIndex(where: { $0.id == division.id }),
                   PagingUtil.isLastPage(index: index, pagingInterval: 10, count: divisions.count) {
                    await viewModel.fetchDivisions(lastId: division.id)
                }
            }
        }
        .animation(.easeOut(duration: 0.2), value: viewModel.divisionMembers)
    }
    
    private func toggleAccordion(for divisionId: Int) {
        if expandedDivisionId.contains(divisionId) {
            expandedDivisionId.remove(divisionId)
        } else {
            expandedDivisionId.insert(divisionId)
        }
    }
    
    private var controlButtons: some View {
        HStack(alignment: .center, spacing: 8) {
            DodamButton.fullWidth(
                title: "전체 취소"
            ) {
                resetSelectedMembers()
            }
            .role(.assistive)
            .frame(width: controlButtonsSize.width / 3)
            
            DodamButton.fullWidth(
                title: "추가"
            ) {
                Task {
                    let selectedMemberIds: [String] = selectedMembers.flatMap { division in
                        division.value.filter { $0.value }.map { String($0.key) }
                    }
                    
                    if !selectedMemberIds.isEmpty {
                        await viewModel.addMembers(id: id, memberId: selectedMemberIds)
                    }
                }
            }
        }
        .background(GeometryReader { proxy in
            Color.clear.onAppear {
                controlButtonsSize = proxy.size
            }
        })
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }
    
    private func resetSelectedMembers() {
        for key in selectedMembers.keys {
            selectedMembers[key]?.keys.forEach { selectedMembers[key]?[$0] = false }
        }
    }
}
