//
//  PracticeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PracticeView: View {
    let program: Program
    var body: some View {
        ZStack {
//            Color.lightBright
//                .ignoresSafeArea()
            
//            SquirrelInWheel()
//                .stroke(.lightBright, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .opacity(0.2)
//                .frame(width: 500, height: 500)
//                .offset(y: 000)
                
            
            VStack {
                Spacer()
                ExerciseView(exercise: Exercise.catCow)
                PracticeSequenceView()
                    .frame(width: 320)
                Spacer()
                PlayerView()
                Spacer()
            }
            .navigationTitle(program.name)
            .navigationBarTitleDisplayMode(.inline)
        }
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
            PracticeView(program: Program.personal)
        }
    }
}
