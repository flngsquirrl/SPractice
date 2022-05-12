//
//  ExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct ExerciseView: View {
    
    var exercise: Exercise
    @ObservedObject var clock: Clock
    
    var body: some View {
        VStack {
            Text("\(exercise.name)")
                .font(.largeTitle.bold())
            
            Text("\(exercise.type.rawValue)")
            
            ClockView(clock: clock)
                .frame(width: 320, height: 120)
            
            Text("\(exercise.tasks[0].name)")
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightOrange
                .ignoresSafeArea()
            ExerciseView(exercise: Exercise.catCow, clock: Clock.simpleCountdown)
        }
    }
}
