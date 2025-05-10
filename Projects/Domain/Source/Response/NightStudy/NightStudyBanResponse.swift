import Foundation

public struct NightStudyBanResponse: ResponseProtocol {
    public let started: String
    public let ended: String
    public let banReason: String
    
    public init(started: String, ended: String, banReason: String) {
        self.started = started
        self.ended = ended
        self.banReason = banReason
    }
}
