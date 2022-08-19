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
    
    @State private var isPracticeDetailsShown = false
    
    @State private var showRestartConfirmation = false
    @State private var wasRunningAtPracticeRestartRequest = false
    
    @ObservedObject var practice: Practice
    
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
                .onAppear(perform: practice.prepare)
                .onDisappear(perform: practice.pause)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        closePracticeButton
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        restartButtonWithIcon
                        soundButton
                        summaryButton
                    }
                }
                .sheet(isPresented: $isPracticeDetailsShown) {
                    practice.resumeClock()
                } content: {
                    PracticeSummaryView(practice: practice)
                }
                .alert(endOfPracticeTitle, isPresented: $practice.isCompleted) {
                    restartButton
                    closePracticeButton
                }
                .alert("If you restart the practice, your progress will be lost.", isPresented: $showRestartConfirmation) {
                    restartButton
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
            if wasRunningAtPracticeRestartRequest {
                practice.resumeClock()
            }
        }
    }
    
    var closePracticeButton: some View {
        Button("Close", role: .cancel) {
            dismiss()
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            practice.restart()
        }
    }
    
    var restartButtonWithIcon: some View {
        RestartIconButton {
            if practice.isStarted {
                wasRunningAtPracticeRestartRequest = practice.isRunning
                practice.pauseClock()
                showRestartConfirmation = true
            } else {
                practice.restart()
            }
        }
        .animation(.default, value: isRestartPracticeDisabled)
        .disabled(isRestartPracticeDisabled)
    }
    
    var isRestartPracticeDisabled: Bool {
        practice.isFirstExercise && !practice.isCurrentExerciseStarted
    }
    
    var soundButton: some View {
        Button {
            withAnimation {
                practice.toggleSound()
            }
        } label: {
            Image(systemName: isSoundOn ? "bell" : "bell.slash")
                .frame(width: 25)
        }
    }
    
    var isSoundOn: Bool {
        practice.isSoundOn
    }
    
    var summaryButton: some View {
        Button {
            isPracticeDetailsShown.toggle()
            practice.pauseClock()
        } label: {
            Image(systemName: "list.bullet.rectangle")
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView(practice: Practice(from: ProgramTemplate.personal))
    }
}
