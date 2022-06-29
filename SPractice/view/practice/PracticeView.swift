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
    
    @State private var isPracticeSequenceShown = true
    @State private var isSoundOn = true
    
    @ObservedObject var practice: Practice
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(stops: [
                    .init(color: .lightNavy, location: 0.3),
                    .init(color: .creamy, location: 1),
                ]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    ExerciseView(practice: practice)
                    
                    if isPracticeSequenceShown {
                        PracticeSequenceView(practice: practice)
                    }
                    Spacer()
                    PlayerView(player: practice.player)
                    Spacer()
                }
                .frame(maxWidth: 320)
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
                            isSoundOn.toggle()
                        }
                    } label: {
                        Image(systemName: isSoundOn ? "bell.fill" : "bell.slash")
                    }
                    
                    Button() {
                        withAnimation {
                            isPracticeSequenceShown.toggle()
                        }
                    } label: {
                        Image(systemName: isPracticeSequenceShown ? "list.bullet.rectangle.fill" : "list.bullet.rectangle")
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PracticeView(practice: Practice(from: ProgramTemplate.personal))
        }
    }
}
