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
    enum InfoStep: Int, Comparable {
        case name = 0
        case studentInfo
        case phone
        case phoneCode
        case email
        case emailCode
        
        static func < (lhs: Self, rhs: Self) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    enum AuthStep: Int, Comparable {
        case id = 0
        case pw
        case checkPw
        case finished
        
        static func < (lhs: Self, rhs: Self) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    // MARK: - State
    @Published var selectedRole: Role?
    // - info
    @Published var infoStep: InfoStep = .name
    @Published var nameText: String = ""
    @Published var studentInfoText: String = ""
    @Published var emailText: String = ""
    @Published var emailCodeText: String = ""
    @Published var isSendEmailCode: Bool = false
    @Published var phoneText: String = ""
    @Published var phoneCodeText: String = ""
    @Published var isSendPhoneCode: Bool = false
    @Published var connectStudents: [ConnectStudent] = []
    
    var clearedPhoneText: String {
        phoneText.split(separator: "-").joined()
    }
    
    // - auth
    @Published var authStep: AuthStep = .id
    @Published var idText: String = ""
    @Published var pwText: String = ""
    @Published var checkPwText: String = ""
    
    // MARK: - Repository
    @Inject var memberRepository: any MemberRepository
    
    // MARK: - Method
    @MainActor
    func postJoin(_ completion: @escaping () -> Void) async {
        guard let selectedRole else { return }
        
        do {
            switch selectedRole {
            case .student:
                _ = try await memberRepository.postStudentJoin(
                    .init(
                        id: idText,
                        pw: pwText,
                        name: nameText,
                        email: emailText,
                        phone: clearedPhoneText,
                        grade: getNumbersFromString(studentInfoText)[0],
                        room: getNumbersFromString(studentInfoText)[1],
                        number: getNumbersFromString(studentInfoText)[2]
                    )
                )
            case .parent:
                _ = try await memberRepository.postParentJoin(
                    .init(
                        id: idText,
                        pw: pwText,
                        name: nameText,
                        relationInfo: connectStudents.map { $0.toRequest() },
                        phone: clearedPhoneText,
                        authCode: phoneCodeText
                    )
                )
            default:
                break
            }
            completion()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func sendEmailCode() async {
        do {
            try await memberRepository.postAuthCode(
                type: .email,
                .init(
                    identifier: emailText
                )
            )
            self.isSendEmailCode = true
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func verifyEmailCode(
        completion: @escaping (Result<Void, Error>) -> Void
    ) async {
        do {
            try await memberRepository.postVerifyAuthCode(
                type: .email,
                .init(
                    identifier: emailText,
                    authCode: emailCodeText
                )
            )
            completion(.success(()))
        } catch {
            completion(.failure(error))
            print(error)
        }
    }
    
    @MainActor
    func sendPhoneCode() async {
        do {
            try await memberRepository.postAuthCode(
                type: .phone,
                .init(
                    identifier: clearedPhoneText
                )
            )
            self.isSendPhoneCode = true
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func verifyPhoneCode(completion: @escaping (Result<Void, Error>) -> Void) async {
        do {
            try await memberRepository.postVerifyAuthCode(
                type: .phone,
                .init(
                    identifier: clearedPhoneText,
                    authCode: phoneCodeText
                )
            )
            completion(.success(()))
        } catch {
            completion(.failure(error))
            print(error)
        }
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
