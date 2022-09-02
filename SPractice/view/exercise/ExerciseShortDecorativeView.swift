//
//  ExerciseShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.06.22.
//

import SwiftUI

struct ExerciseShortDecorativeView<T>: View where T: Exercise {

    private let exercise: T
    private var isIconAccented: Bool
    private var isNameAccented: Bool
    private var accentColor: Color
    private var isFilled: Bool

    @ObservedObject private var settings = SettingsManager.settings

    init(for exercise: T, isIconAccented: Bool = false, isNameAccented: Bool = false,
         accentColor: Color = .customAccentColor, isFilled: Bool = false) {
        self.exercise = exercise
        self.isIconAccented = isIconAccented
        self.isNameAccented = isNameAccented
        self.accentColor = accentColor
        self.isFilled = isFilled
    }

    var body: some View {
        HStack {
            if isIconAccented {
                ExerciseTypeImage(type: exercise.type, isFilled: isFilled)
                    .foregroundColor(accentColor)
            } else {
                ExerciseTypeImage(type: exercise.type)
            }

            if isNameAccented {
                Text(exercise.name)
                    .foregroundColor(accentColor)
            } else {
                Text(exercise.name)
            }
        }
    }
}

struct ExerciseShortDecorativeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("exercises")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana)
            }

            Group {
                Text("templates with durations")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoDuration)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType)
            }

            Group {
                Text("templates without durations")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoDuration)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType)
            }
        }
    }
}
