//
//  BusApplySelectSeatView.swift
//  Feature
//
//  Created by hhhello0507 on 2/26/25.
//

import SwiftUI
import DDS

struct BusApplySelectSeatView: View {
    var body: some View {
        DodamScrollView.medium(
            title: "버스 좌석을\n선택해 주세요"
        ) {
            ZStack {
                VStack(spacing: 4) {
                    Image(icon: .arrowLeft)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foreground(DodamColor.Label.assistive)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 58)
                    ForEach(0..<11, id: \.self) { rowIndex in
                        if rowIndex < 10 {
                            HStack(spacing: 4) {
                                BusSeat(text: "\(rowIndex * 4 + 1)", selected: false)
                                BusSeat(text: "\(rowIndex * 4 + 2)", selected: false)
                                Spacer().frame(width: 44)
                                BusSeat(text: "\(rowIndex * 4 + 3)", selected: false)
                                BusSeat(text: "\(rowIndex * 4 + 4)", selected: false)
                            }
                        } else {
                            HStack(spacing: 4) {
                                ForEach(0..<5, id: \.self) { index in
                                    BusSeat(text: "\(40 + index + 1)", selected: false)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 4)
                .padding([.horizontal, .bottom], 18)
                .background(DodamColor.Background.neutral)
                .clipShape(.large)
                HStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 9)
                            .foreground(DodamColor.Line.normal)
                            .frame(width: 12, height: 108)
                            .offset(y: 48)
                        Spacer()
                        RoundedRectangle(cornerRadius: 9)
                            .foreground(DodamColor.Line.normal)
                            .frame(width: 12, height: 108)
                            .offset(y: -48)
                    }
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 9)
                            .foreground(DodamColor.Line.normal)
                            .frame(width: 12, height: 108)
                            .offset(y: 48)
                        Spacer()
                        RoundedRectangle(cornerRadius: 9)
                            .foreground(DodamColor.Line.normal)
                            .frame(width: 12, height: 108)
                            .offset(y: -48)
                    }
                }
                .zIndex(-1)
            }
            .frame(width: 272)
            .padding(.top, 8)
        }
        .safeAreaInset(edge: .bottom) {
            DodamButton.fullWidth(
                title: "신청"
            ) {
                // TODO: Api
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}

/*
 Column(
             modifier = Modifier
                 .fillMaxHeight()
                 .padding(paddingValues)
                 .padding(horizontal = 16.dp),
             horizontalAlignment = Alignment.CenterHorizontally
         ) {
             LazyColumn(
                 modifier = Modifier
                     .width(272.dp)
                     .drawBehind {
                         drawRoundRect(
                             color = lineNormal,
                             cornerRadius = CornerRadius(9.dp.toPx()),
                             size = Size(
                                 width = 12.dp.toPx(),
                                 height = 108.dp.toPx(),
                             ),
                             topLeft = Offset(
                                 x = -7.dp.toPx(),
                                 y = 48.dp.toPx(),
                             ),
                         )
                         drawRoundRect(
                             color = lineNormal,
                             cornerRadius = CornerRadius(9.dp.toPx()),
                             size = Size(
                                 width = 12.dp.toPx(),
                                 height = 108.dp.toPx(),
                             ),
                             topLeft = Offset(
                                 x = size.width - 5.dp.toPx(),
                                 y = 48.dp.toPx(),
                             ),
                         )

                         drawRoundRect(
                             color = lineNormal,
                             cornerRadius = CornerRadius(9.dp.toPx()),
                             size = Size(
                                 width = 12.dp.toPx(),
                                 height = 108.dp.toPx(),
                             ),
                             topLeft = Offset(
                                 x = -7.dp.toPx(),
                                 y = size.height - 156.dp.toPx(),
                             ),
                         )
                         drawRoundRect(
                             color = lineNormal,
                             cornerRadius = CornerRadius(9.dp.toPx()),
                             size = Size(
                                 width = 12.dp.toPx(),
                                 height = 108.dp.toPx(),
                             ),
                             topLeft = Offset(
                                 x = size.width - 5.dp.toPx(),
                                 y = size.height - 156.dp.toPx(),
                             ),
                         )
                     }
                     .background(
                         color = DodamTheme.colors.backgroundNeutral,
                         shape = DodamTheme.shapes.large,
                     ),
                 verticalArrangement = Arrangement.spacedBy(4.dp),
             ) {
                 item {
                     Spacer(modifier = Modifier.height(4.dp))
                     Box(
                         modifier = Modifier
                             .height(58.dp)
                             .fillMaxWidth()
                             .padding(
                                 horizontal = 18.dp,
                             ),
                         contentAlignment = Alignment.CenterEnd
                     ) {
                         Icon(
                             modifier = Modifier.size(22.dp),
                             imageVector = DodamIcons.ArrowLeft.value,
                             contentDescription = null,
                             tint = DodamTheme.colors.labelAssistive
                         )
                     }
                 }
                 items(11) { rowIndex ->
                     if (rowIndex < 10) {
                         Row(
                             horizontalArrangement = Arrangement.spacedBy(4.dp)
                         ) {
                             Spacer(modifier = Modifier.width(12.dp))
                             BusSeat(
                                 text = "${rowIndex * 4 + 1}",
                                 selected = false
                             )
                             BusSeat(
                                 text = "${rowIndex * 4 + 2}",
                                 selected = false
                             )
                             Spacer(modifier = Modifier.size(44.dp))
                             BusSeat(
                                 text = "${rowIndex * 4 + 3}",
                                 selected = false
                             )
                             BusSeat(
                                 text = "${rowIndex * 4 + 4}",
                                 selected = false
                             )
                         }
                     } else {
                         Row(
                             modifier = Modifier.padding(
                                 bottom = 18.dp,
                             ),
                             horizontalArrangement = Arrangement.spacedBy(4.dp)
                         ) {
                             Spacer(modifier = Modifier.width(12.dp))
                             for (i in 0 until 5) {
                                 BusSeat(
                                     text = "${40 + i + 1}",
                                     selected = false
                                 )
                             }
                         }
                     }
                 }
             }
 */

struct BusSeat: View {
    let text: String
    let selected: Bool
    
    var body: some View {
        Text(text)
            .body1(.medium)
            .foreground(
                selected
                ? DodamColor.Static.white
                : DodamColor.Label.assistive
            )
            .frame(width: 44, height: 44)
            .background(
                selected
                ? DodamColor.Primary.normal
                : DodamColor.Background.normal
            )
            .clipShape(.rect(cornerRadius: 4))
    }
}
