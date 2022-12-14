//
//  ExerciseShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.06.22.
//

import SwiftUI

struct ExerciseShortDecorativeView: View {

    private let exercise: ExerciseTemplate
    private var isAccented: Bool
    private var accentColor: Color

    init(for exercise: ExerciseTemplate, isAccented: Bool = false, accentColor: Color = .customAccentColor) {
        self.exercise = exercise
        self.isAccented = isAccented
        self.accentColor = accentColor
    }

    var body: some View {
        HStack {
            ExerciseTypeImage(type: exercise.type,
                              isFilled: isAccented)
            Text(exercise.name)
                .font(.headline)
        }
        .foregroundColor(isAccented ? accentColor : nil)
    }
}

struct ExerciseShortDecorativeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("simple")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasisthasana)
            }

            Group {
                Text("accented with default color")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow, isAccented: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA, isAccented: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasisthasana, isAccented: true)
            }

            Group {
                Text("accented with non-default color")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow, isAccented: true, accentColor: .mint)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA, isAccented: true, accentColor: .mint)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasisthasana, isAccented: true, accentColor: .mint)
            }
        }
    }
}
