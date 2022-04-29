//
//  ExcerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct ExcerciseView: View {
    
    var excercise: Excercise
    
    var body: some View {
        VStack {
            Text("\(excercise.name)")
                .font(.largeTitle.bold())
            
            Text("\(excercise.type.rawValue)")
            
            ClockView(setTo: excercise.tasks[0].duration!, isCountdown: true)
            Text("\(excercise.tasks[0].name)")
        }
    }
}

struct ExcerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            ExcerciseView(excercise: Excercise.catCow)
        }
    }
}
