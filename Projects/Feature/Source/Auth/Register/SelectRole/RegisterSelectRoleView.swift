import SwiftUI
import DDS
import FlowKit

struct RegisterSelectRoleView: View {
    @Flow var flow
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            DodamTopAppBar.medium(
                title: "해당하는 곳을\n선택해 주세요"
            )
            VStack(alignment: .leading, spacing: 24) {
                Spacer()
                HStack(spacing: 8) {
                    SelectRoleCell(selectedIndex: selectedIndex, index: 0) {
                        selectedIndex = 0
                    }
                    SelectRoleCell(selectedIndex: selectedIndex, index: 1) {
                        selectedIndex = 1
                    }
                }
                Spacer()
                Spacer()
                DodamButton.fullWidth(
                    title: "다음"
                ) {
                    if selectedIndex == 0 {
                        flow.push(RegisterInfoView())
                    } else {
                        // TODO: 이후 학부모 선택 시 ChildrenManage 뷰로 이동
                    }
                    
                }
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 16)
        }
        .background(DodamColor.Background.neutral)
    }
}

private struct SelectRoleCell: View {
    @Namespace private var animation
    
    private let selectedIndex: Int
    private let index: Int
    private let action: () -> Void
    
    private var selected: Bool {
        selectedIndex == index
    }
    
    init(
        selectedIndex: Int,
        index: Int,
        action: @escaping () -> Void
    ) {
        self.selectedIndex = selectedIndex
        self.index = index
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                HStack(spacing: 4) {
                    Text(index == 0 ? "학생" : "학부모")
                        .foreground(DodamColor.Label.normal)
                        .opacity(selected ? 1 : 0.5)
                        .font(selected ? .body1(.bold) : .body1(.medium))
                        .matchedGeometryEffect(id: 0, in: animation)
                    if selected {
                        Image(icon: .checkmark)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foreground(DodamColor.Primary.normal)
                    }
                }
                Image(index == 0 ? "Student" : "Parent")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
            }
            .padding(.top, 16)
            .frame(maxWidth: .infinity)
            .background(DodamColor.Background.normal)
            .clipShape(.large)
            .overlay {
                RoundedRectangle(cornerRadius: DodamShape.large.radius)
                    .stroke(
                        selected
                        ? DodamColor.Primary.normal.color.rawValue
                        : DodamColor.Line.neutral.color.rawValue,
                        lineWidth: selected ? 2 : 1
                    )
            }
        }
        .animation(.spring(duration: 0.4), value: selectedIndex)
    }
}

#Preview {
    RegisterSelectRoleView()
}
