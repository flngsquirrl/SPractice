//
//  ExercisePropertiesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.08.22.
//

import SwiftUI

struct ExercisePropertiesView<T>: View where T: Exercise {

    var exercise: T

    var body: some View {
        Section {
            HStack(alignment: .center) {
                if exercise.isExample {
                    ExampleMark()
                }
                Text(name)
                    .font(.headline)
            }
            if showDescription {
                Text(exercise.description)
                    .foregroundColor(.secondary)
            }
        } footer: {
            if exercise.isExample {
                HStack(spacing: 0) {
                    Text("This is an example ")
                    InfoButton(isFooter: true)
                }
            }
        }
        .rowLeadingAligned()

        Section {
            HStack {
                Text("Type")
                InfoButton()
                Spacer()
                ExerciseTypeView(type: exercise.type, mode: .iconAndText)
                    .foregroundColor(.secondary)
            }

            if showDetails {
                HStack {
                    Text("Duration")
                    InfoButton()
                    Spacer()
                    ExerciseDurationView(for: exercise, isVerbose: true)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text("Intensity")
                    InfoButton()
                    Spacer()
                    IntensityView(intensity: exercise.intensity, mode: .iconAndText)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    var name: String {
        if exercise.isService {
            return SettingsManager.restName
        }
        return exercise.name
    }

    var showDetails: Bool {
        exercise.isTypeSet
    }

    var showDescription: Bool {
        !exercise.description.isEmptyString
    }
}

struct ExerciseDetailsContent_Previews: PreviewProvider {
    static var previews: some View {
        ExercisePropertiesView(exercise: PracticeExercise(from: ExerciseTemplate.catCow)!)
    }
}
