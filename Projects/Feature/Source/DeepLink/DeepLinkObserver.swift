import Foundation
import Domain

public class DeepLinkObserver: ObservableObject {
    @Published public var shouldShowDialog = false
    @Published public var clientId: String?
    @Published public var code: String?

    private var observer: NSObjectProtocol?

    public init() {
        observer = NotificationCenter.default.addObserver(
            forName: .didReceiveDeepLink,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.clientId = DeepLinkManager.shared.getClientId()
            self?.code = DeepLinkManager.shared.getCode()
            self?.shouldShowDialog = true
        }
    }

    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
