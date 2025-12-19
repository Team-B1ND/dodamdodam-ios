import Foundation

public struct DeepLinkLoginRequest: RequestProtocol {
    public let code: String
    public let clientId: String
    public let access: String
    public let refresh: String

    public init(
        code: String,
        clientId: String,
        access: String,
        refresh: String
    ) {
        self.code = code
        self.clientId = clientId
        self.access = access
        self.refresh = refresh
    }
}
