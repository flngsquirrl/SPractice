//
//  IntroExerciseImage.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.09.22.
//

import SwiftUI

struct IntroExerciseImage: View {

    var type: ExerciseType

    init(for type: ExerciseType) {
        self.type = type
    }

    var body: some View {
        Image(systemName: ExerciseTypeImage.imageName(for: type, isFilled: true))
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .font(.largeTitle.bold())
    }
}
