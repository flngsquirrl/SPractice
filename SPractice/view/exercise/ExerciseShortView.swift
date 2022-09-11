//
//  ExerciseShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.06.22.
//

import SwiftUI

struct ExerciseShortView<E: Exercise, Icon: View>: View {

    @ObservedObject var settings = SettingsManager.settings

    private let exercise: E
    @ViewBuilder private var icon: Icon

    init(for exercise: E, icon: () -> Icon) {
        self.exercise = exercise
        self.icon = icon()
    }

    var body: some View {
        HStack {
            icon
            Text(name)

            if displayDetails {
                Spacer()
                Group {
                    ExerciseDurationView(for: exercise)
                    IntensityView(intensity: exercise.intensity)
                }
                .foregroundColor(.secondary)
            }
        }
    }

    var displayDetails: Bool {
        exercise.isTypeSet
    }

    var name: String {
        if exercise.isService {
            return SettingsManager.restName
        }
        return exercise.name
    }
}

struct ExerciseShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("foreground test")
                ExerciseShortView(for: PracticeExercise.catCow) {
                    ExerciseTypeImage(type: .flow)
                }
                .foregroundColor(.secondary)

                ExerciseShortView(for: PracticeExercise.catCow) {
                    ExerciseTypeImage(type: .flow)
                }
            }
        }
    }
}
