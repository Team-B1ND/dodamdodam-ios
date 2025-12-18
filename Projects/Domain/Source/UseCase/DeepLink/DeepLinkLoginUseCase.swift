import Foundation
import SignKit

public protocol DeepLinkLoginUseCase {
    func execute(clientId: String, code: String) async throws
}

public final class DeepLinkLoginUseCaseImpl: DeepLinkLoginUseCase {

    private let authRepository: AuthRepository

    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func execute(clientId: String, code: String) async throws {
        guard let accessToken = Sign.accessToken,
              let refreshToken = Sign.refreshToken else {
            throw NSError(domain: "DeepLink", code: -1, userInfo: [NSLocalizedDescriptionKey: "로그인이 필요합니다"])
        }

        let request = DeepLinkLoginRequest(
            code: code,
            clientId: clientId,
            access: accessToken,
            refresh: refreshToken
        )

        try await authRepository.postQRLogin(request)
    }
}
