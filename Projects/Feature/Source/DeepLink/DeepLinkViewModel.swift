import Foundation
import Domain
import DIContainer
import DDS

public class DeepLinkViewModel: ObservableObject {
    private let deepLinkLoginUseCase: DeepLinkLoginUseCase
    private var observer: NSObjectProtocol?

    public init(
        deepLinkLoginUseCase: DeepLinkLoginUseCase? = nil
    ) {
        self.deepLinkLoginUseCase = deepLinkLoginUseCase ?? DependencyProvider.shared.container.resolve(DeepLinkLoginUseCase.self)!

        observer = NotificationCenter.default.addObserver(
            forName: .didReceiveDeepLink,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleDeepLinkNotification()
        }
    }

    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    private func handleDeepLinkNotification() {
        guard let clientId = DeepLinkManager.shared.getClientId(),
              let code = DeepLinkManager.shared.getCode() else {
            return
        }

        onDeepLinkReceived?(clientId, code)
    }

    public var onDeepLinkReceived: ((String, String) -> Void)?
    public var onLoginSuccess: ((String) -> Void)?
    public var onLoginFailure: ((String) -> Void)?

    @MainActor
    public func performQRLogin(clientId: String, code: String) async {
        do {
            let (isSuccess, message) = try await deepLinkLoginUseCase.execute(clientId: clientId, code: code)

            if isSuccess {
                onLoginSuccess?(message)
            } else {
                onLoginFailure?(message)
            }
        } catch {
            onLoginFailure?(error.localizedDescription)
        }
    }
}
