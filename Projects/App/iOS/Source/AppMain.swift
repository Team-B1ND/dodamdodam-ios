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
    @StateObject private var deepLinkHandler = DeepLinkObserver()

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
            }
            .onOpenURL { url in
                DeepLinkManager.shared.handleUniversalLink(url)
            }
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                if let url = userActivity.webpageURL {
                    DeepLinkManager.shared.handleUniversalLink(url)
                }
            }
            .onChange(of: deepLinkHandler.shouldShowDialog) { shouldShow in
                if shouldShow,
                   let clientId = deepLinkHandler.clientId,
                   let code = deepLinkHandler.code {
                    showQRLoginDialog(clientId: clientId, code: code)
                    deepLinkHandler.shouldShowDialog = false
                }
            }
        }
    }

    private func showQRLoginDialog(clientId: String, code: String) {
        dialogProvider.present(
            .init(title: "QR 로그인")
            .message("웹에서 로그인하시겠습니까?\n\n다음 정보에 접근합니다:\n이름, 전화번호, 이메일, 프로필이미지, 기숙사 정보, 외박 정보, 동아리 정보")
            .primaryButton("로그인") {
                Task {
                    await self.performQRLogin(clientId: clientId, code: code)
                }
            }
            .secondaryButton("취소")
        )
    }

    @MainActor
    private func performQRLogin(clientId: String, code: String) async {
        guard let useCase = DependencyProvider.shared.container.resolve(DeepLinkLoginUseCase.self) else {
            return
        }

        do {
            try await useCase.execute(clientId: clientId, code: code)
        } catch {
        }
    }
}
