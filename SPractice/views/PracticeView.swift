//
//  PracticeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Combine
import SwiftUI

struct PracticeView: View {
    
    @StateObject var practice: Practice
    
    var body: some View {
        VStack {
            Spacer()
            ExerciseView(exercise: practice.currentExercise, clock: practice.clock)
            //PracticeSequenceView()
            Spacer()
            PlayerView(player: practice.player) {
                playPractice()
            } pauseClicked: {
                pausePractice()
            } backwardClicked: {
                moveToPreviousExercise()
            } forwardClicked: {
                moveToNextExercise()
            } stopClicked: {
                finishPractice()
            }

            Spacer()
        }
        .frame(width: 320)
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
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .lightOrange, location: 0),
                .init(color: .creamy, location: 1),
            ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            PracticeView(practice: Practice(for: Program.personal))
        }
    }
}
