//
//  RegisterViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import Combine

class RegisterViewModel: ObservableObject {
    
    // MARK: - State
    @Published var infoStep: Int = 0
    @Published var authStep: Int = 0
    @Published var phoneText: String = ""
    @Published var infoText: String = ""
    @Published var emailText: String = ""
    @Published var nameText: String = ""
    @Published var idText: String = ""
    @Published var pwText: String = ""
    @Published var checkPwText: String = ""
    @Published var isSuccessJoin: Bool = false
    
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
                    grade: getNumbersFromString(infoText)[0],
                    room: getNumbersFromString(infoText)[1],
                    number: getNumbersFromString(infoText)[2]
                )
            )
            isSuccessJoin = true
            completion()
        } catch let error {
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
