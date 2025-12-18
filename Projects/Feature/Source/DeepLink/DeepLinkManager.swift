import Foundation

public extension Notification.Name {
    static let didReceiveDeepLink = Notification.Name("didReceiveDeepLink")
}

public class DeepLinkManager {
    public static let shared = DeepLinkManager()

    private init() {}

    private var clientId: String?
    private var code: String?

    public func setDeepLinkParams(clientId: String, code: String) {
        self.clientId = clientId
        self.code = code

        NotificationCenter.default.post(name: .didReceiveDeepLink, object: nil)
    }

    public func getClientId() -> String? {
        return clientId
    }

    public func getCode() -> String? {
        return code
    }

    public func reset() {
        clientId = nil
        code = nil
    }
}
