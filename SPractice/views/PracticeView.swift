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
            Color.lightBright
                .ignoresSafeArea()
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
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightBright
                .ignoresSafeArea()
            PracticeView(program: Program.personal)
        }
    }
}
