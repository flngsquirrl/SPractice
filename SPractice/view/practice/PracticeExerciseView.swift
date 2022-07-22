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
                Button {
                    // show details modal
                } label: {
                Image(systemName: ExerciseTypeImage.imageName(for: practice.currentExercise.type, isFilled: true))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.lightOrange)
                    .font(.largeTitle.bold())
                }
        
                Spacer()

                Button {
                    practice.restartExercise()
                } label: {
                    ZStack {
                        Circle()
                            .fill(.lightOrange)
                            .opacity(practice.isCurrentExerciseStarted ? 1 : 0.6)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .foregroundColor(Color(UIColor.secondarySystemBackground))
                            .font(.largeTitle.bold())
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                }
                .animation(.default, value: practice.isCurrentExerciseStarted)
                .disabled(!practice.isCurrentExerciseStarted)
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
