//
//  LoginViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/14/24.
//

import Combine
import Foundation
import SignKit
import DIContainer
import Domain

class LoginViewModel: ObservableObject {
    
    // MARK: - State
    @Published var idText: String = ""
    @Published var pwText: String = ""
    @Published var isShowingAlert: Bool = false
    @Published var isChecked1: Bool = false
    @Published var isChecked2: Bool = false
    @Published var isModalPresented: Bool = false
    
    // MARK: - Repository
    @Inject var authRepository: any AuthRepository
    
    // MARK: - Method
    @MainActor
    func postLogin(_ completion: @escaping () -> Void) async {
        isShowingAlert = false
        do {
            guard let pushToken = UserDefaults.standard.string(forKey: "pushToken") else {
                print("pushToken is nil")
                isShowingAlert = true
                return
            }
            _ = try await authRepository.postLogin(
                .init(id: idText, pw: pwText, pushToken: pushToken)
            )
            completion()
        } catch let error {
            print(error)
            isShowingAlert = true
        }
    }
    
    var isChecked: Bool {
        isChecked1 && isChecked2
    }
    
    func isValidIdAndPw() -> Bool {
        let isValidId: Bool = !idText.isEmpty
        let isValidPw: Bool = !pwText.isEmpty
        
        return isValidId && isValidPw
    }
}
