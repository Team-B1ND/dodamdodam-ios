//
//  AppMain.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI
import DIContainer
import Domain
import Feature
import Shared
import DDS
import FlowKit
import Realm

@main
struct AppMain: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        Pretendard.register()
        DependencyProvider.shared.register()
    }
    
    @StateObject private var dialogProvider = DialogProvider()
    @StateObject private var datePickerProvider = DatePickerProvider()
    @StateObject private var timePickerProvider = TimePickerProvider()
    @StateObject private var flow = FlowProvider(rootView: MainView())
    @StateObject private var deepLinkViewModel = DeepLinkViewModel()

    var body: some Scene {
        WindowGroup {
            DodamModalProvider(
                dialogProvider: dialogProvider,
                datePickerProvider: datePickerProvider,
                timePickerProvider: timePickerProvider
            ) {
                FlowPresenter(flow: flow)
            }
            .ignoresSafeArea()
            .onAppear {
#if DEBUG
                print("Realm DB location: \(RLMRealmConfiguration.default().fileURL!)")
#endif
                setupDeepLinkHandler()
            }
            .onOpenURL { url in
                DeepLinkManager.shared.handleUniversalLink(url)
            }
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                if let url = userActivity.webpageURL {
                    DeepLinkManager.shared.handleUniversalLink(url)
                }
            }
        }
    }

    private func setupDeepLinkHandler() {
        deepLinkViewModel.onDeepLinkReceived = { [self] clientId, code in
            self.showQRLoginDialog(clientId: clientId, code: code)
        }

        deepLinkViewModel.onLoginSuccess = { [self] message in
            self.showLoginResultDialog(title: "로그인 성공", message: message)
        }

        deepLinkViewModel.onLoginFailure = { [self] message in
            self.showLoginResultDialog(title: "로그인 실패", message: message)
        }
    }

    private func showQRLoginDialog(clientId: String, code: String) {
        dialogProvider.present(
            .init(title: "QR 로그인")
            .message("웹에서 로그인하시겠습니까?\n\n다음 정보에 접근합니다:\n이름, 전화번호, 이메일, 프로필이미지, 기숙사 정보, 외박 정보, 동아리 정보")
            .primaryButton("로그인") {
                Task {
                    await self.deepLinkViewModel.performQRLogin(clientId: clientId, code: code)
                }
            }
            .secondaryButton("취소")
        )
    }

    private func showLoginResultDialog(title: String, message: String) {
        dialogProvider.present(
            .init(title: title)
            .message(message)
            .primaryButton("확인")
        )
    }
}
