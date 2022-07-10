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
                            ExerciseView(practice: practice)
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
                            ExerciseView(practice: practice)
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
                        Button("Close") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        
                        Button() {
                            withAnimation {
                                practice.restart()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise.circle")
                        }
                        .disabled(!practice.isStarted)
                        
                        Button() {
                            withAnimation {
                                isSoundOn.toggle()
                            }
                        } label: {
                            Image(systemName: isSoundOn ? "bell" : "bell.slash")
                        }
                        
                        Button() {
                            isPracticeDetailsShown.toggle()
                        } label: {
                            Image(systemName: "list.bullet.rectangle")
                        }
                    }
                }
                .sheet(isPresented: $isPracticeDetailsShown) {
                    PracticeSummaryView(practice: practice)
                }
            }
            .accentColor(.customAccentColor)
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView(practice: Practice(from: PreparedProgram.personal))
    }
}
