import FlowKit
import SwiftUI
import DDS
import Shared

struct ApplyView: View {
    
    @StateObject var studyViewModel = NightStudyApplyViewModel()
    @StateObject var projectViewModel = NightProjectApplyViewModel()
    @State var selection: Int
    @DodamDialog private var dialog
    @Flow var flow
    
    init(isProject: Bool = false) {
        _selection = State(initialValue: isProject ? 1 : 0)
    }
    
    var body: some View {
        DodamScrollView.medium(title: "심야 자습 신청하기") {
            VStack(spacing: 12) {
                if selection == 0 {
                    NightStudyApplyView(viewModel: studyViewModel)
                }
                if selection == 1 {
                    NightProjectApplyView(viewModel: projectViewModel)
                }
            }
            .padding(.horizontal)
        }
        .subView {
            DodamSegmentedButton(
                labels: ["개인", "프로젝트"],
                selection: $selection
            )
        }
        .overlay(alignment: .bottom) {
            if selection == 0 {
                DodamButton.fullWidth(
                    title: "확인"
                ) {
                    await studyViewModel.postNightStudy()
                    flow.pop()
                }
                .disabled(
                    studyViewModel.reasonText.count < 10
                )
                .onChange(of: studyViewModel.nightStudyApplyFailed) { _ in
                    let dialog = Dialog(title: "실패")
                        .message(studyViewModel.nightStudyApplyAlertMessage)
                        .primaryButton("확인") {
                            flow.pop()
                        }
                    self.dialog.present(dialog)
                }
                .padding([.bottom, .horizontal], 16)
            } else {
                DodamButton.fullWidth(
                    title: "확인"
                ) {
                    await projectViewModel.postNightStudyProject()
                    flow.pop()
                }
                .disabled(
                    projectViewModel.projectName.isEmpty ||
                    projectViewModel.projectDescription.count < 10 ||
                    projectViewModel.selectedStudents.isEmpty
                )
                .onChange(of: projectViewModel.nightStudyApplyFailed) { _ in
                    let dialog = Dialog(title: "실패")
                        .message(projectViewModel.nightStudyApplyAlertMessage)
                        .primaryButton("확인") {
                            flow.pop()
                        }
                    self.dialog.present(dialog)
                }
                .padding([.bottom, .horizontal], 16)
            }
        }
        .background(DodamColor.Background.neutral)
    }
}

#Preview {
    ApplyView()
}
