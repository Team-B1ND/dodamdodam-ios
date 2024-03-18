//
//  TextField.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI

public struct DodamTextField: View {
    
    private let title: String
    private let isSecured: Bool
    private let isFirstResponder: Bool
    @Binding private var text: String
    
    private init(
        title: String,
        isSecured: Bool,
        isFirstResponder: Bool = false,
        text: Binding<String>
    ) {
        self.title = title
        self.isSecured = isSecured
        self.isFirstResponder = isFirstResponder
        self._text = text
    }
    
    public func makeFirstResponder() -> Self {
        .init(title: title,
              isSecured: isSecured,
              isFirstResponder: true,
              text: $text)
    }
    
    public static func `default`(
        title: String,
        text: Binding<String>
    ) -> Self {
        .init(
            title: title,
            isSecured: false,
            text: text
        )
    }
    
    public static func secured(
        title: String,
        text: Binding<String>
    ) -> Self {
        .init(
            title: title,
            isSecured: true,
            text: text
        )
    }
    
    @FocusState private var isFocused: Bool
    @State private var animatedFocusing: Bool = false
    
    private var isHighlighted: Bool {
        animatedFocusing || !text.isEmpty
    }
    
    private var foregroundColor: AnyShapeStyle {
        isFocused ? .init(.tint) : .init(Color(.tertiary))
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .leading) {
                Text(title)
                    .scaleEffect(isHighlighted ? 0.75 : 1,
                                 anchor: .topLeading)
                    .padding(.top, isHighlighted ? -30 : 0)
                Group {
                    if isSecured {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                }
                .focused($isFocused)
                .foregroundStyle(Color(.label))
            }
            .frame(height: 41, alignment: .bottomLeading)
            .font(.dodamBody2)
            Rectangle()
                .frame(height: 1)
        }
        .foregroundStyle(foregroundColor)
        .onChange(of: isFocused) { newValue in
            withAnimation(.spring(duration: 0.1)) {
                animatedFocusing = newValue
            }
        }
        .onAppear {
            if isFirstResponder {
                isFocused = true
            }
        }
    }
}

#Preview {
    struct DodamTextFieldPreview: View {
        
        @State private var idText: String = .init()
        @State private var pwText: String = .init()
        
        var body: some View {
            VStack(spacing: 20) {
                DodamTextField.default(
                    title: "아이디",
                    text: $idText
                )
                DodamTextField.secured(
                    title: "비밀번호",
                    text: $pwText
                )
            }
            .padding()
        }
    }
    return DodamTextFieldPreview()
}
