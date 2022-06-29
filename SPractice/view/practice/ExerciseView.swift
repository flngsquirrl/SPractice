//
//  ExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct ExerciseView: View {
    
    @ObservedObject var practice: Practice
    
    var body: some View {
        VStack {
            HStack {
                Spacer()

                Image(systemName: ExerciseTypeImage.imageName(for: practice.currentExercise.type, isFilled: true))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .opacity(0.8)
                    .foregroundColor(.lightOrange)
                    .font(.largeTitle.bold())
            }
            
            Text("\(practice.currentExercise.name)")
                .font(.largeTitle.bold())
            
            Text("\(practice.currentExercise.type.rawValue)")
                .font(.body.bold())
                .foregroundColor(.secondary)
            
            ClockView(clock: practice.clock)
            
            Text("\(practice.currentTask.name)")
                .font(.body.bold())
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            ExerciseView(practice: Practice(from: ProgramTemplate.personal))
                .frame(width: 320)
        }
    }
}
