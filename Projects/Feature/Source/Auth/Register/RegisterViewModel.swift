//
//  RegisterViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import Combine
import Domain
import DIContainer

class RegisterViewModel: ObservableObject {
    
    // MARK: - State
    // - info
    @Published var infoStep: Int = 0
    @Published var nameText: String = ""
    @Published var studentInfoText: String = ""
    @Published var emailText: String = ""
    @Published var emailCodeText: String = ""
    @Published var isSendEmailCode: Bool = false
    @Published var phoneText: String = ""
    @Published var phoneCodeText: String = ""
    @Published var isSendPhoneCode: Bool = false
    
    // - auth
    @Published var authStep: Int = 0
    @Published var idText: String = ""
    @Published var pwText: String = ""
    @Published var checkPwText: String = ""
    
    // MARK: - Repository
    @Inject var memberRepository: any MemberRepository
    
    // MARK: - Method
    @MainActor
    func postJoin(_ completion: @escaping () -> Void) async {
        do {
            _ = try await memberRepository.postJoin(
                .init(
                    id: idText,
                    email: emailText,
                    name: nameText,
                    phone: phoneText,
                    pw: pwText,
                    grade: getNumbersFromString(studentInfoText)[0],
                    room: getNumbersFromString(studentInfoText)[1],
                    number: getNumbersFromString(studentInfoText)[2]
                )
            )
            completion()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func sendEmailCode() {
        self.isSendEmailCode = true
        // TODO: Handle
    }
    
    @MainActor
    func verifyEmailCode(completion: @escaping () -> Void) {
        // TODO: Handle
        completion()
    }
    
    @MainActor
    func sendPhoneCode() {
        self.isSendPhoneCode = true
        // TODO: Handle
    }
    
    @MainActor
    func verifyPhoneCode(completion: @escaping () -> Void) {
        // TODO: Handle
        completion()
    }
    
    private func getNumbersFromString(_ infoText: String) -> [Int] {
        let components = infoText.split(separator: " ")
        let numbers = components.compactMap {
            Int($0.replacingOccurrences(
                of: "\\D",
                with: "",
                options: .regularExpression)
            )
        }
        
        return numbers
    }
}
