//
//  PhoneSessionManager.swift
//  Shared
//
//  Created by 김은찬 on 6/11/25.
//

import Foundation
import WatchConnectivity
import Domain

public final class PhoneSessionManager: NSObject, WCSessionDelegate {
    
    public static let shared = PhoneSessionManager()
    
    private override init() {
        super.init()
        activate()
    }
    
    private func activate() {
        guard WCSession.isSupported() else { return }
        let session = WCSession.default
        session.delegate = self
        session.activate()
    }
    
    public func sendMealDataToWatch(meals: [MealModel]) {
        guard WCSession.default.isReachable else {
            print("Watch 연결 안 됨")
            return
        }
        
        do {
            let data = try JSONEncoder().encode(meals)
            WCSession.default.sendMessage(["meals": data], replyHandler: nil) { error in
                print("전송 실패: \(error)")
            }
        } catch {
            print("인코딩 실패: \(error)")
        }
    }
    
    // MARK: - WCSessionDelegate
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("세션 상태: \(activationState), 오류: \(String(describing: error))")
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession) {
        print("세션 비활성화됨")
    }
    
    public func sessionDidDeactivate(_ session: WCSession) {
        print("세션 재활성화 시도")
        WCSession.default.activate()
    }
}
