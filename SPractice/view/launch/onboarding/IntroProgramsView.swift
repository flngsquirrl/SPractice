//
//  IntroProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.09.22.
//

import SwiftUI

struct IntroProgramsView: View {

    @Environment(\.verticalSizeClass) var sizeClass

    let regularExerciseMatrix: [[ExerciseType]] = [
        [.flow, .timer, .timer, .flow],
        [.timer, .flow, .timer, .tabata, .flow],
        [.tabata, .flow, .timer]
    ]

    let compactExerciseMatrix: [[ExerciseType]] = [
        [.flow, .timer, .timer],
        [.timer, .flow, .timer],
        [.tabata, .flow]
    ]

    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Programs of your own")
                    .introTitle(geo: geo)

                if sizeClass == .regular {
                    ExerciseMatrix(regularExerciseMatrix)
                } else {
                    ExerciseMatrix(compactExerciseMatrix)
                }
            }
        }
    }
}

struct IntroProgramsView_Previews: PreviewProvider {
    static var previews: some View {
        IntroProgramsView()
    }
}
