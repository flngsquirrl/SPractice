//
//  PracticeExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PracticeExerciseView: View {
    
    @ObservedObject var practice: Practice
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: ExerciseTypeImage.imageName(for: practice.currentExercise.type, isFilled: true))
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.lightOrange)
                    .font(.largeTitle.bold())
        
                Spacer()

                RoundIconButton(imageName: "info.circle.fill", disabled: false) {
                    // show details
                }
                
                RoundIconButton(imageName: "arrow.clockwise.circle.fill", disabled: !practice.isCurrentExerciseStarted) {
                    practice.restartExercise()
                }
                .animation(.default, value: practice.isCurrentExerciseStarted)
            }
            
            Text("\(practice.currentExercise.name)")
                .font(.title.bold())
                .truncated()
            
            Text("\(practice.currentExercise.exerciseType.rawValue)")
                .font(.body.bold())
                .foregroundColor(.secondary)
            
            ClockView(clock: practice.clock)
            Text("\(practice.currentTask.name)")
                .font(.body.bold())
                .foregroundColor(.secondary)
        }
    }
}

struct PracticeExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            PracticeExerciseView(practice: Practice(from: ProgramTemplate.personal))
                .wrapped()
                .frame(width: 320)
            
        }
    }
}
