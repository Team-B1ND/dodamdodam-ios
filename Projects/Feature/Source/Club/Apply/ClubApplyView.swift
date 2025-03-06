//
//  ApplyView.swift
//  Feature
//
//  Created by dgsw30 on 2/20/25.
//

import SwiftUI
import DDS
import Shared

struct ClubApplyView: View {
    @State var selection: Int = 0
    @State private var selection1: [(text: String, club: String?)] = [(text: "", club: nil)]
    @State private var selection2: [(text: String, club: String?)] = [(text: "", club: nil)]
    @State private var club1: [String] = ["B1ND", "ALT", "DUCAMI", "CNS"]
    @State private var club2: [String] = ["Connect", "InD", "Soccer", "hoho", "hoho"]
    
    var body: some View {
        DodamScrollView.medium(title: "동아리 신청") {
            if selection == 0 {
                VStack(spacing: 16) {
                    ForEach(selection1.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 4) {
                            Menu {
                                ForEach(club1, id: \.self) { club in
                                    Button {
                                        selection1[index].club = club
                                    } label: {
                                        Text(club)
                                    }
                                    
                                    .disabled(selection1.contains { $0.club == club })
                                }
                            } label: {
                                HStack {
                                    Text("\(index + 1)순위:")
                                        .foreground(DodamColor.Label.normal)
                                        .font(.headline(.bold))
                                    
                                    Text(selection1[index].club ?? "동아리 선택")
                                    //                                    .font(.headline(.regular))
                                    //                                    .foreground(DodamColor.Primary)
                                    
                                    Image(systemName: "chevron.up.chevron.down")
                                    //                                    .font(.headline(.regular))
                                    //                                    .foreground(DodamColor.Primary)
                                }
                            }
                            
                            DodamTextField.editor(
                                title: "자기소개",
                                text: Binding(
                                    get: { selection1[index].text },
                                    set: { selection1[index].text = $0 }
                                )
                            )
                            .font(.body1(.medium))
                            .foreground(DodamColor.Label.normal)
                            .frame(height: 300)
                            Spacer()
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 363)
                        .background(DodamColor.Background.normal)
                        .clipShape(.medium)
                        
                        if index == selection1.count - 1 && index != 2 {
                            Button {
                                selection1.append((text: "", club: nil))
                            } label: {
                                VStack(alignment: .center) {
                                    Image(icon: .plus)
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .foreground(DodamColor.Label.alternative)
                                        .padding(.vertical)
                                }
                                .frame(maxWidth: .infinity)
                                .background(DodamColor.Background.normal)
                                .clipShape(.medium)
                            }
                        }
                    }
                }
                .padding()
            }
            if selection == 1 {
                VStack(spacing: 16) {
                    ForEach(selection2.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 4) {
                            Menu {
                                ForEach(club2, id: \.self) { club in
                                    Button {
                                        selection2[index].club = club
                                    } label: {
                                        Text(club)
                                    }
                                    
                                    .disabled(selection2.contains { $0.club == club })
                                }
                            } label: {
                                HStack {
                                    Text("자율동아리")
                                        .foreground(DodamColor.Label.normal)
                                        .font(.headline(.bold))
                                    
                                    Text(selection2[index].club ?? "동아리 선택")
                                    //                                    .font(.headline(.regular))
                                    //                                    .foreground(DodamColor.Primary)
                                    
                                    Image(systemName: "chevron.up.chevron.down")
                                    //                                    .font(.headline(.regular))
                                    //                                    .foreground(DodamColor.Primary)
                                }
                            }
                            
                            DodamTextField.editor(
                                title: "자기소개",
                                text: Binding(
                                    get: { selection2[index].text },
                                    set: { selection2[index].text = $0 }
                                )
                            )
                            .font(.body1(.medium))
                            .foreground(DodamColor.Label.normal)
                            .frame(height: 300)
                            Spacer()
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 363)
                        .background(DodamColor.Background.normal)
                        .clipShape(.medium)
                        
                        if index == selection2.count - 1 && index != club2.count - 1 {
                            Button {
                                selection2.append((text: "", club: nil))
                            } label: {
                                VStack(alignment: .center) {
                                    Image(icon: .plus)
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .foreground(DodamColor.Label.alternative)
                                        .padding(.vertical)
                                }
                                .frame(maxWidth: .infinity)
                                .background(DodamColor.Background.normal)
                                .clipShape(.medium)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .subView {
            DodamSegmentedButton(
                labels: ["창체", "자율"],
                selection: $selection
            )
        }
        .overlay(alignment: .bottom) {
            DodamButton.fullWidth(
                title: "동아리 입부 신청하기"
            ) {
                
            }
            .padding([.bottom, .horizontal], 16)
        }
        .ignoresSafeArea(.keyboard)
        .background(DodamColor.Background.neutral)
        .hideKeyboardWhenTap()
    }
}
