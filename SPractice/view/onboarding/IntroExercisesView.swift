//
//  IntroExercises.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.09.22.
//

import SwiftUI

struct IntroExercisesView: View {

    let exerciseMatrix: [[ExerciseType]] = [[.flow], [.timer], [.tabata]]

    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("3 types of exercises")
                    .introTitle(geo: geo)

                ExerciseMatrix(exerciseMatrix)
            }
        }
    }
}

struct IntroExercises_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightOrange
                .ignoresSafeArea()

            IntroExercisesView()
        }
    }
}
