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

    @ObservedObject var practice: Practice
    @ObservedObject var viewModel: ViewModel

    init(for template: ProgramTemplate) {
        let settings = PracticeSettingsManager.shared.getSettings(for: template.id)
        let practice = Practice(for: template, with: settings)
        self.practice = practice
        self.viewModel = ViewModel(for: practice, with: settings)
    }

    var body: some View {
        GeometryReader { geo in
            NavigationView {
                Group {
                    if sizeClass == .compact {
                        HStack(alignment: .top) {
                            VStack {
                                Spacer()
                                PracticeExerciseView(practice: practice)
                                    .wrapped()
                                Spacer()
                            }
                            VStack {
                                Spacer()
                                PracticeSequenceView(practice: practice)
                                Spacer()
                                PlayerView(player: practice.player)
                                Spacer()
                            }
                        }
                        .frame(width: geo.size.width)
                    } else {
                        VStack {
                            Spacer()
                            PracticeExerciseView(practice: practice)
                                .wrapped()

                            PracticeSequenceView(practice: practice)
                            Spacer()
                            PlayerView(player: practice.player)
                            Spacer()
                        }
                        .frame(width: min(geo.size.width * 0.8, 500))
                    }
                }
                .onDisappear {
                    practice.pauseClock()
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
                    practice.resumeClock()
                } content: {
                    PracticeSummaryView(practice: practice)
                }
                .alert(endOfPracticeTitle, isPresented: $practice.isCompleted) {
                    restartAlertButton
                    closePracticeButton
                }
                .alert("If you restart the practice, your progress will be lost.", isPresented: $viewModel.needRestartConfirmation) {
                    restartAlertButton
                    closeAlertButton
                }
            }
            .accentColor(.customAccentColor)
        }
    }

    var endOfPracticeTitle: String {
        var text: String
        if practice.isStarted {
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
            practice.restart()
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
            viewModel.toggleSound()
        } label: {
            Image(systemName: practice.isSoundOn ? "bell" : "bell.slash")
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
    static var previews: some View {
        PracticeView(for: .personal)
    }
}
