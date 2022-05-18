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
            
            Text("\(practice.currentExercise.type.rawValue)")
            
            ClockView(clock: practice.clock)
                .frame(width: 320, height: 120)
            
            Text("\(practice.currentTask.name)")
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightOrange
                .ignoresSafeArea()
            ExerciseView(practice: Practice(for: Program.personal))
        }
    }
}
