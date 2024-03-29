//
//  OnboardingView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/13/24.
//

import SwiftUI
import DDS

struct OnboardingView: View {
    
    // UI test state
    @State var isChecked1: Bool = false
    @State var isChecked2: Bool = false
    @State var isPresented: Bool = false
    
    @InjectObject var viewModel: OnboardingViewModel
    @Flow var flow
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Dodam.icon(.logo)
                    .resizable()
                    .scaledToFit()
                    .dodamColor(.onPrimary)
                Text("어린아이가 탈 없이 잘 놀며 자라는 모양.")
                    .font(.body(.medium))
                    .dodamColor(.onPrimary)
            }
            .frame(height: 85)
            .padding(.top, 80)
            Spacer()
            VStack(spacing: 16) {
                DodamButton.fullWidth(
                    title: "로그인"
                ) {
                    flow.push(LoginView())
                }
                .padding(.horizontal, 16)
                
                HStack(spacing: 0) {
                    Text("처음 이용하시나요? ")
                        .font(.body(.small))
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("회원가입")
                            .font(.system(size: 14, weight: .bold))
                            .underline()
                    }
                }
                .dodamColor(.onPrimary)
            }
            .padding(.bottom, 16)
        }
        .background(
            Image(.onboard)
                .resizable()
                .offset(x: -30)
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
        .dodamModal(isPresented: $isPresented) {
            modalSheetView
        }
    }
    
    private var modalSheetView: some View {
        VStack(spacing: 16) {
            Button {
                if isChecked1 && isChecked2 == true {
                    (isChecked1, isChecked2) = (false, false)
                } else {
                    (isChecked1, isChecked2) = (true, true)
                }
            } label: {
                HStack(spacing: 14) {
                    Dodam.icon(.checkmarkCircle)
                        .resizable()
                        .frame(width: 24, height: 24)
                    // true -> change boolean state
                        .dodamColor(
                            isChecked1 && isChecked2 ? .primary : .outline
                        )
                        .padding(.leading, 18)
                        .padding(.vertical, 12)
                    Text("모두 동의합니다")
                        .font(.body(.medium))
                        .dodamColor(.onBackground)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Dodam.color(.outline), lineWidth: 1.5)
                }
            }
            HStack {
                Button {
                    isChecked1.toggle()
                } label: {
                    Dodam.icon(.checkmark)
                        .resizable()
                        .frame(width: 17)
                        .dodamColor(
                            isChecked1 ? .primary : .outline
                        )
                }
                Button {
                    flow.push(HomeView())
                } label: {
                    Text("(필수) 서비스 이용약관")
                        .font(.body(.small))
                        .dodamColor(.onSurface)
                    Spacer()
                    Dodam.icon(.chevronRight)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 17)
                        .dodamColor(.onSurface)
                }
            }
            .frame(height: 17)
            
            HStack {
                Button {
                    isChecked2.toggle()
                } label: {
                    Dodam.icon(.checkmark)
                        .resizable()
                        .frame(width: 17)
                        .dodamColor(
                            isChecked2 ? .primary : .outline
                        )
                }
                Button {
                    flow.push(HomeView())
                } label: {
                    Text("(필수) 개인정보 수집 및 이용에 대한 안내")
                        .font(.body(.small))
                        .dodamColor(.onSurface)
                    Spacer()
                    Dodam.icon(.chevronRight)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 17)
                        .dodamColor(.onSurface)
                }
            }
            .frame(height: 17)
            
            DodamButton.fullWidth(
                title: "다음"
            ) {
                flow.push(RegisterInfoView())
            }
            .disabled(!(isChecked1 && isChecked2))
        }
        .background(Dodam.color(.background))
    }
}

#Preview {
    OnboardingView()
}
