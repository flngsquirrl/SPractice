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
            Text("\(practice.currentExercise.name)")
                .font(.largeTitle.bold())
                .foregroundColor(.creamy)
            
            Text("\(practice.currentExercise.type.rawValue)")
                .font(.body.bold())
                .foregroundColor(.creamy)
            
            ClockView(clock: practice.clock)
                .frame(width: 320, height: 120)
            
            Text("\(practice.currentTask.name)")
                .font(.body.bold())
                .foregroundColor(.creamy)
        }
        .padding(30)
        .frame(maxWidth: .infinity)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightNavy
                .ignoresSafeArea()
            ExerciseView(practice: Practice(for: Program.personal))
        }
    }
}
