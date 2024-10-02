//
//  EditProfileViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 9/20/24.
//

import Foundation
import DIContainer
import Domain

final class EditMemberInfoViewModel: ObservableObject {
    
    // MARK: - State
    @Published var name: String
    @Published var email: String
    @Published var profileImage: String?
    @Published var phone: String
    @Published var isUploading = false
    
    var validInput: Bool {
        !name.isEmpty && !email.isEmpty && phone.count == 13 && !isUploading
    }
    
    init(name: String, email: String, profileImage: String?, phone: String) {
        self.name = name
        self.email = email
        self.profileImage = profileImage
        self.phone = phone.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d{4})", with: "$1-$2-$3", options: .regularExpression)
    }
    
    // MARK: - Repository
    @Inject var memberRepository: MemberRepository
    @Inject var uploadRepository: UploadRepository
    
    // MARK: - Method
    @MainActor
    func editProfile(
        completion: @escaping () -> Void,
        failure: @escaping () -> Void
    ) async {
        do {
            try await memberRepository.patchMemberInfo(
                .init(email: email, name: name, profileImage: profileImage, phone: phone.replacingOccurrences(of: "-", with: ""))
            )
            completion()
        } catch {
            failure()
            print(error)
        }
    }
    
    @MainActor
    func uploadProfileImage(data: Data) async {
        isUploading = true
        defer { isUploading = false }
        do {
            let url = try await uploadRepository.postUpload(data: data)
            self.profileImage = url
        } catch {
            print(error)
        }
    }
}
