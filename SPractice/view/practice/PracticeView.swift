//
//  PracticeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Combine
import SwiftUI

struct PracticeView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.verticalSizeClass) var sizeClass

    @EnvironmentObject var activityMonitor: ActivityMonitor

    @ObservedObject var viewModel: ViewModel

    init(for template: ProgramTemplate) {
        self.viewModel = ViewModel(for: template)
    }

    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                Group {
                    if sizeClass == .compact {
                        HStack(alignment: .top) {
                            VStack {
                                Spacer()
                                PracticeExerciseView(practice: viewModel.practice)
                                    .wrapped()
                                Spacer()
                            }
                            VStack {
                                Spacer()
                                PracticeSequenceView(practice: viewModel.practice)
                                Spacer()
                                PlayerView(player: viewModel.practice.player)
                                Spacer()
                            }
                        }
                        .frame(width: geo.size.width)
                    } else {
                        VStack {
                            Spacer()
                            PracticeExerciseView(practice: viewModel.practice)
                                .wrapped()

                            PracticeSequenceView(practice: viewModel.practice)
                            Spacer()
                            PlayerView(player: viewModel.practice.player)
                            Spacer()
                        }
                        .frame(width: LayoutUtils.centralFrameWidth(parentContainerSize: geo.size))
                    }
                }
                .onDisappear {
                    viewModel.practice.pauseClock()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        closePracticeButton
                    }

                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        restartButton
                        soundButton
                        summaryButton
                    }
                }
                .sheet(isPresented: $viewModel.isPracticeDetailsShown) {
                    viewModel.practice.resumeClock()
                } content: {
                    PracticeSummaryView(practice: viewModel.practice)
                }
                .alert(endOfPracticeTitle, isPresented: $viewModel.practice.isCompleted) {
                    restartAlertButton
                    closePracticeButton
                }
                .alert("If you restart the practice, your progress will be lost.", isPresented: $viewModel.needRestartConfirmation) {
                    restartAlertButton
                    closeAlertButton
                }
                .onChange(of: activityMonitor.isActive) { isActive in
                    viewModel.processScenePhaseChange(isActive: isActive)
                }
            }
            .accentColor(.customAccentColor)
        }
    }

    var endOfPracticeTitle: String {
        var text: String
        if viewModel.practice.isStarted {
            text = "You have finished the practice."
        } else {
            text = "You have reached the end of the practice."
        }
        return text
    }

    var closeAlertButton: some View {
        Button("Close", role: .cancel) {
            viewModel.resumeAfterRestartPractice()
        }
    }

    var restartAlertButton: some View {
        Button("Restart") {
            viewModel.practice.restart()
        }
    }

    var closePracticeButton: some View {
        Button("Close", role: .cancel) {
            dismiss()
        }
    }

    var restartButton: some View {
        RestartIconButton {
            viewModel.processRestartRequest()
        }
        .animation(.default, value: viewModel.isRestartPracticeDisabled)
        .disabled(viewModel.isRestartPracticeDisabled)
    }

    var soundButton: some View {
        Button {
            withAnimation {
                viewModel.toggleSound()
            }
        } label: {
            Image(systemName: viewModel.practice.isSoundOn ? "bell" : "bell.slash")
                .frame(width: 25)
        }
    }

    var summaryButton: some View {
        Button {
            viewModel.showSummary()
        } label: {
            Image(systemName: "list.bullet.rectangle")
        }
    }
}

struct PracticeView_Previews: PreviewProvider {

    static var activityMonitor = ActivityMonitor()

    static var previews: some View {
        PracticeView(for: .simpleYoga)
            .environmentObject(activityMonitor)
    }
}
