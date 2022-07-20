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
    @State private var isSoundOn = true
    
    @State private var showRestartConfirmation = false
    @State private var wasRunningAtPracticeRestartRequest = false
    
    @ObservedObject var practice: Practice
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                Group {
                    if sizeClass == .compact {
                        HStack(alignment: .top) {
                            PracticeExerciseView(practice: practice)
                                .frame(maxHeight: .infinity)
                                .wrapped()
                            VStack {
                                Spacer()
                                PracticeSequenceView(practice: practice)
                                    .frame(maxWidth: .infinity)
                                Spacer()
                                PlayerView(player: practice.player)
                                Spacer()
                            }
                            .padding(.leading)
                        }
                    } else {
                        VStack {
                            Spacer()
                            PracticeExerciseView(practice: practice)
                                .wrapped()

                            PracticeSequenceView(practice: practice)
                                .frame(maxWidth: .infinity)
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
                .alert("Namaste", isPresented: $practice.isCompleted) {
                    restartButton
                    closePracticeButton
                } message: {
                    endOfPracticeText
                }
                .alert("Please, note", isPresented: $showRestartConfirmation) {
                    restartButton
                    closeAlertButton
                } message: {
                    Text("If you restart the practice, you progress will be lost")
                }
            }
            .accentColor(.customAccentColor)
        }
    }
    
    var endOfPracticeText: some View {
        var text: String
        if practice.isStarted {
            text = "You have finished the practice"
        } else {
            text = "You have reached the end of the practice"
        }
        return Text(text)
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
        Button() {
            withAnimation {
                isSoundOn.toggle()
            }
        } label: {
            Image(systemName: isSoundOn ? "bell" : "bell.slash")
                .frame(width: 25)
        }
    }
    
    var summaryButton: some View {
        Button() {
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
