//
//  PracticeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Combine
import SwiftUI

struct PracticeView: View {
    
    @ObservedObject var practice: Practice
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .lightNavy, location: 0.3),
                .init(color: .creamy, location: 1),
            ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                ExerciseView(practice: practice)
                //PracticeSequenceView()
                Spacer()
                PlayerView(player: practice.player)
                Spacer()
            }
        }
        .onDisappear(perform: cancelPractice)
        //.frame(width: 320)
        .navigationTitle(practice.program.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func playPractice() {
        practice.run()
    }
    
    func pausePractice() {
        practice.pause()
    }
    
    func moveToNextExercise() {
        practice.moveToNextExercise()
    }
    
    func moveToPreviousExercise() {
        practice.moveToPreviousExercise()
    }
    
    func finishPractice() {
        practice.finish()
    }
    
    func cancelPractice() {
        practice.cancel()
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .lightNavy, location: 0.3),
                .init(color: .creamy, location: 1),
            ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            PracticeView(practice: Practice(for: Program.personal))
        }
    }
}
