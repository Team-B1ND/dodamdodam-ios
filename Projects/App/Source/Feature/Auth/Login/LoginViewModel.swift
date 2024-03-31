//
//  LoginViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/14/24.
//

import Combine
import SignKit

class LoginViewModel: ObservableObject {
    
    // MARK: - State
    @Published var idText: String = ""
    @Published var pwText: String = ""
    @Published var isShowingAlert: Bool = false
    
    // MARK: - Repository
    @Inject var authRepository: any AuthRepository
    
    // MARK: - Method
    @MainActor
    func postLogin(_ completion: @escaping () -> Void) async {
        isShowingAlert = false
        do {
            _ = try await authRepository.postLogin(
                .init(id: idText, pw: pwText)
            )
            completion()
        } catch let error {
            print(error)
            isShowingAlert = true
        }
    }
    
    func isValidIdAndPw() -> Bool {
        let isValidId: Bool = !idText.isEmpty
        let isValidPw: Bool = !pwText.isEmpty
        return isValidId && isValidPw
    }
}
