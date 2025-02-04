//
//  ChildrenManageView.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import Domain
import DIContainer

class ChildrenManageViewModel: ObservableObject {
    // MARK: State
    @Published var studentCode: String = ""
    @Published var relation: String?
    @Published var etcRelation = ""
    @Published var isETCMode = false
    
    // MARK: Repository
//    @Inject private var
    
    // MARK: Method
    @MainActor
    func getChild() async -> ConnectStudent? {
        guard let relation else { return nil }
        
        do {
            return ConnectStudent(
                code: studentCode,
                relation: isETCMode ? etcRelation : relation,
                profileImage: nil
            )
        } catch {
            print(error)
            return nil
        }
    }
}
