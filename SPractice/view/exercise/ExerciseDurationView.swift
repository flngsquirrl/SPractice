//
//  ExerciseDurationView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.06.22.
//

import SwiftUI

struct ExerciseDurationView: View {
    
    private let duration: Duration
    private let mode: DurationView.Mode
    private let isVerbose: Bool
    
    init<T>(for template: T, mode: DurationView.Mode = .padded, isVerbose: Bool = false) where T: Exercise {
        var duration: Duration
        if template.type == .tabata {
            duration = .known(SettingsManager.tabataExerciseDuration)
        } else if template.isService {
            duration = .known(SettingsManager.pauseDurationItem.value)
        } else {
            duration = template.duration
        }
        self.duration = duration
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
