//
//  WatchSessionManager.swift
//  DodamDodam
//
//  Created by 김은찬 on 6/11/25.
//

import WatchConnectivity
import Foundation
import Domain

public final class WatchSessionManager: NSObject, WCSessionDelegate, ObservableObject {
    @Published var meal: [MealModel]?
    public static let shared = WatchSessionManager()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let data = message["meals"] as? Data {
            if let meal = try? JSONDecoder().decode([MealModel].self, from: data) {
                DispatchQueue.main.async {
                    self.meal = meal
                }
            }
        }
    }
    
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("세션 상태: \(activationState), 오류: \(String(describing: error))")
    }
    
//    public func sessionDidBecomeInactive(_ session: WCSession) {
//        print("세션 비활성화됨")
//    }
//    
//    public func sessionDidDeactivate(_ session: WCSession) {
//        print("세션 재활성화 시도")
//        WCSession.default.activate()
//    }
}
