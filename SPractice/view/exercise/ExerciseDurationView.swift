//
//  ExerciseDurationView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.06.22.
//

import SwiftUI

struct ExerciseDurationView<T>: View where T: Exercise {

    @EnvironmentObject var settingsManager: SettingsManager

    private let template: T
    private let mode: DurationView.Mode
    private let isVerbose: Bool

    init(for template: T, mode: DurationView.Mode = .padded, isVerbose: Bool = false) where T: Exercise {
        self.template = template
        self.mode = mode
        self.isVerbose = isVerbose
    }

    var body: some View {
        switch duration {
        case .known(let time):
            DurationView(duration: time, mode: mode)
        case .unknown:
            HStack {
                LayoutUtils.unknownDurationText
                if isVerbose {
                    Text("not set")
                }
            }
        case .unlimited:
            HStack {
                LayoutUtils.unlimitedDurationImage
            }
        }
    }

    var duration: Duration {
        if template.type == .tabata {
            return .known(settingsManager.exerciseDuration)
        } else if template.isService {
            return .known(settingsManager.restDurationItem.value)
        } else {
            return template.duration
        }
    }
}

struct ExerciseDurationView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Text("templates")
            ExerciseDurationView(for: ExerciseTemplate.catCowNoType)
            ExerciseDurationView(for: ExerciseTemplate.catCowNoDuration)
            ExerciseDurationView(for: ExerciseTemplate.surjaNamascarA)

            Text("templates verbose")
            ExerciseDurationView(for: ExerciseTemplate.catCowNoType, isVerbose: true)
            ExerciseDurationView(for: ExerciseTemplate.catCowNoDuration, isVerbose: true)
            ExerciseDurationView(for: ExerciseTemplate.surjaNamascarA, isVerbose: true)

            Text("exercises")
            ExerciseDurationView(for: PracticeExercise.catCow)
        }
    }
}
