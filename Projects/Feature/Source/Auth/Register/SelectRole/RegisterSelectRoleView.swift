import SwiftUI
import DDS
import FlowKit
import Domain

private extension Role {
    var image: String? {
        switch self {
        case .student: "Student"
        case .parent: "Parent"
        default: nil
        }
    }
}

struct RegisterSelectRoleView: View {
    @Flow var flow
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            DodamTopAppBar.medium(
                title: "해당하는 곳을\n선택해 주세요"
            )
            VStack(alignment: .leading, spacing: 24) {
                Spacer()
                HStack(spacing: 8) {
                    SelectRoleCell(selectedRole: $viewModel.selectedRole, role: .student)
                    SelectRoleCell(selectedRole: $viewModel.selectedRole, role: .parent)
                }
                Spacer()
                Spacer()
                DodamButton.fullWidth(
                    title: "다음"
                ) {
                    switch viewModel.selectedRole {
                    case .student:
                        flow.push(RegisterInfoView().environmentObject(viewModel))
                    case .parent:
                        flow.push(ChildrenManageViewForRegister().environmentObject(viewModel))
                    default:
                        break
                    }
                }
                .disabled(viewModel.selectedRole == nil)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 16)
        }
        .background(DodamColor.Background.neutral)
    }
}

private struct SelectRoleCell: View {
    @Namespace private var animation
    
    @Binding private var selectedRole: Role?
    private let role: Role
    
    private var selected: Bool {
        selectedRole == role
    }
    
    init(
        selectedRole: Binding<Role?>,
        role: Role
    ) {
        self._selectedRole = selectedRole
        self.role = role
    }
    
    var body: some View {
        Button {
            selectedRole = role
        } label: {
            VStack(spacing: 16) {
                HStack(spacing: 4) {
                    Text(role.korean)
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
                Image(role.image!)
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
        .animation(.spring(duration: 0.4), value: selectedRole)
    }
}

#Preview {
    RegisterSelectRoleView()
}
