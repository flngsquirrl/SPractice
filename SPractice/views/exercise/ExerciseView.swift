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

                Image(systemName: practice.currentExercise.type.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .opacity(0.8)
                    .foregroundColor(.lightOrange)
                    .font(.largeTitle.bold())
                    .padding(.trailing, 20)
            }
            
            Text("\(practice.currentExercise.name)")
                .font(.largeTitle.bold())
                .foregroundColor(.creamy)
            
            Text("\(practice.currentExercise.type.rawValue)")
                .font(.body.bold())
                .foregroundColor(.creamy)
            
            ClockView(clock: practice.clock)
            
            Text("\(practice.currentTask.name)")
                .font(.body.bold())
                .foregroundColor(.creamy)
        }
        .padding([.top, .bottom] ,20)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightNavy
                .ignoresSafeArea()
            ExerciseView(practice: Practice(for: Program.personal))
                .border(.black, width: 3)
                .frame(width: 320)
        }
    }
}
