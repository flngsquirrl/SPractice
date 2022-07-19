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
                        closeButton
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
                    closeButton
                } message: {
                    Text("You have finished the practice")
                }
            }
            .accentColor(.customAccentColor)
        }
    }
    
    var closeButton: some View {
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
            practice.restart()
        }
        .disabled(!practice.isStarted)
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
