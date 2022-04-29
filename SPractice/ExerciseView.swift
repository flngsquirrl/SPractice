//
//  ExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct ExerciseView: View {
    
    var exercise: Exercise
    var clock: Clock = Clock.simpleCountdown
    
    var body: some View {
        VStack {
            Text("\(exercise.name)")
                .font(.largeTitle.bold())
            
            Text("\(exercise.type.rawValue)")
            
            ClockView(clock: clock)
            
            Text("\(exercise.tasks[0].name)")
        }.onAppear() {
            clock.start()
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            ExerciseView(exercise: Exercise.catCow)
        }
    }
}
