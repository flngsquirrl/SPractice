//
//  PracticeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PracticeView: View {
    @State var practice: Practice
    @StateObject var playerState = PlayerState()
    
    var body: some View {
        VStack {
            Spacer()
            ExerciseView(exercise: practice.currentExercise)
            //PracticeSequenceView()
            Spacer()
            PlayerView(state: playerState) {
                startPractice()
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
    
    func startPractice() {
        practice.start()
        updatePlayerState()
    }
    
    func pausePractice() {
        practice.pause()
        updatePlayerState()
    }
    
    func moveToNextExercise() {
        practice.moveToNextExercise()
        updatePlayerState()
    }
    
    func moveToPreviousExercise() {
        practice.moveToPreviousExercise()
        updatePlayerState()
    }
    
    func finishPractice() {
        practice.finish()
        updatePlayerState()
    }
    
    func updatePlayerState() {
        playerState.isPlayEnabled = !practice.isRunning && !practice.isFinished
        playerState.isPauseEnabled = practice.isRunning && !practice.isFinished
        playerState.isBackwardEnabled = !practice.isFirstExercise && !practice.isFinished
        playerState.isForwardEnabled = !practice.isLastExercise && !practice.isFinished
        playerState.isStopEnabled = practice.isInProgress && !practice.isFinished
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
