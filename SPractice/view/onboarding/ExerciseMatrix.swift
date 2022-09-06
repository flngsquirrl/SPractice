//
//  ExerciseMatrix.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.09.22.
//

import SwiftUI

struct ExerciseMatrix: View {
    var matrix: [[ExerciseType]]

    init(_ matrix: [[ExerciseType]]) {
        self.matrix = matrix
    }

    var body: some View {
        HStack(alignment: .top) {
            ForEach(0..<matrix.count, id: \.self) { column in
                let types = matrix[column]
                VStack {
                    ForEach(0..<types.count, id: \.self) { row in
                        IntroExerciseImage(for: types[row])
                    }
                }
                .padding(10)
            }
        }
    }
}
