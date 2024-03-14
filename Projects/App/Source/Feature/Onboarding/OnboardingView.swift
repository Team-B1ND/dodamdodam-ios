//
//  OnboardingView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/13/24.
//

import SwiftUI

struct OnboardingView: View {
    
    var body: some View {
        overlayView
            .background(
                Image(.onboard)
                    .resizable()
                    .offset(x: -30)
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
    }
    
    private var overlayView: some View {
        VStack {
            VStack(spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                Text("어린아이가 탈 없이 잘 놀며 자라는 모양.")
                    .font(.body2)
                    .foregroundStyle(.white)
            }
            .frame(height: 85)
            .padding(.top, 80)
            Spacer()
            VStack(spacing: 16) {
                DodamButton.fullWidth(
                    title: "시작하기"
                ) {
                    // action
                }
                .padding(.horizontal, 16)
                
                Button {
                    // action
                } label: {
                    Text("처음 이용하시나요? ")
                        .font(.body3)
                    +
                    Text("회원가입")
                        .font(.system(size: 14, weight: .bold))
                        .underline()
                }
                .foregroundStyle(.white)
            }
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    OnboardingView()
}

