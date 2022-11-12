//
//  ExercisePropertiesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.08.22.
//

import SwiftUI

struct ExercisePropertiesView<T>: View where T: Exercise {

    @EnvironmentObject var settingsManager: SettingsManager

    var exercise: T

    var body: some View {
        Section {
            HStack(alignment: .center) {
                if isExample {
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
            if isExample {
                HStack(spacing: 0) {
                    Text("This is an example ")
                    InfoButton(for: .example, isFooter: true)
                }
            }
        }
        .rowLeadingAligned()

        Section {
            HStack {
                Text("Type")
                InfoButton(for: .execiseType)
                Spacer()
                ExerciseTypeView(type: exercise.type, mode: .textAndIcon)
                    .foregroundColor(.secondary)
            }

            if showDetails {
                HStack {
                    Text("Duration")
                    InfoButton(for: .exerciseDuration)
                    Spacer()
                    ExerciseDurationView(for: exercise, isVerbose: true)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text("Intensity")
                    InfoButton(for: .exerciseIntensity)
                    Spacer()
                    IntensityView(intensity: exercise.intensity, mode: .textAndIcon)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    var isExample: Bool {
        return ExampleUtils.isExample(item: exercise)
    }

    var name: String {
        if exercise.isService {
            return settingsManager.restName
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
        List {
            ExercisePropertiesView(exercise: PracticeExercise.catCow)
                .environmentObject(SettingsManager())
                .environmentObject(InfoController())
        }
    }
}
