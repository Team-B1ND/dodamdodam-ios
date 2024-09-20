//
//  EditProfileView.swift
//  Feature
//
//  Created by hhhello0507 on 9/20/24.
//

import SwiftUI
import DDS
import Domain
import Photos
import PhotosUI
import Shared
import FlowKit
import SwiftUIIntrospect

struct EditMemberInfoView: View {
    @Flow private var flow
    @EnvironmentObject private var dialog: DialogProvider
    @StateObject private var viewModel: EditMemberInfoViewModel
    @State private var image: Data?
    @State private var isDialogPresented = false
    @State private var isPhotoPickerPresented = false
    
    private let memberData: MemberResponse
    
    init(memberData: MemberResponse) {
        self.memberData = memberData
        self._viewModel = .init(
            wrappedValue: .init(
                name: memberData.name,
                email: memberData.email,
                profileImage: memberData.profileImage,
                phone: memberData.phone
            )
        )
    }
    
    func presentDialog(title: String) {
        dialog.present(
            .init(title: title)
            .primaryButton("닫기") {
                flow.pop()
            }
        )
    }
    
    var body: some View {
        DodamScrollView.small(title: "정보 수정") {
            VStack(spacing: 24) {
                DodamAvatar.xxl(url: viewModel.profileImage)
                    .overlay {
                        Button {
                            isDialogPresented = true
                        } label: {
                            Image(icon: .plus)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 16, height: 16)
                                .foreground(DodamColor.Static.white)
                                .padding(8)
                                .background(DodamColor.Primary.normal)
                                .clipShape(Circle())
                                .padding(4)
                        }
                        .scaledButtonStyle()
                        .disabled(viewModel.isUploading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    }
                    .opacity(viewModel.isUploading ? 0.5 : 1)
                    .overlay {
                        if viewModel.isUploading {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                    }
                DodamTextField.default(
                    title: "이름",
                    text: $viewModel.name
                )
                DodamTextField.default(
                    title: "이메일",
                    text: $viewModel.email
                )
                .keyboardType(.emailAddress)
                DodamTextField.default(
                    title: "전화번호",
                    text: $viewModel.phone
                )
                .keyboardType(.numberPad)
                .onChange(of: viewModel.phone) {
                    if let phone = FormatUtil.formatPhone($0) {
                        viewModel.phone = phone
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .background(DodamColor.Background.neutral)
        .safeAreaInset(edge: .bottom) {
            DodamButton.fullWidth(title: "수정 완료") {
                await viewModel.editProfile {
                    presentDialog(title: "정보 수정 성공")
                } failure: {
                    presentDialog(title: "정보 수정 실패")
                }
            }
            .disabled(!viewModel.validInput)
            .padding(.bottom, 12)
            .padding(.horizontal, 16)
        }
        .sheet(isPresented: $isPhotoPickerPresented) { // dodamSheet로 하면 화면이 깨지는 현상 발생
            PhotoPicker(image: $image)
        }
        .confirmationDialog("와우", isPresented: $isDialogPresented) {
            Button("앨범에서 선택") {
                isPhotoPickerPresented = true
            }
            Button("기본 프로필으로 설정") {
                viewModel.profileImage = nil
            }
        }
        .onChange(of: image ?? .init()) { image in
            Task {
                await viewModel.uploadProfileImage(data: image)
            }
        }
        .onChange(of: viewModel.phone) {
            if let phoneText = FormatUtil.formatPhone($0) {
                viewModel.phone = phoneText
            }
        }
    }
}
