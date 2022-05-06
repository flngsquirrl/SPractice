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
        VStack {
            Spacer()
            ExerciseView(exercise: Exercise.catCow)
            Spacer()
            PlayerView()
            Spacer()
        }
        .navigationTitle(program.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .orange, location: 0.3),
                .init(color: .black, location: 1),
            ]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            PracticeView(program: Program.personal)
        }
    }
}
