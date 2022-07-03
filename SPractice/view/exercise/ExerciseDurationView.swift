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
    
    init(for template: ExerciseTemplate, mode: DurationView.Mode = .padded, isVerbose: Bool = false) {
        self.init(type: template.type, duration: template.duration, mode: mode, isVerbose: isVerbose)
    }
    
    init(for exercise: Exercise, mode: DurationView.Mode = .padded, isVerbose: Bool = false) {
        self.init(type: exercise.type, duration: exercise.duration, mode: mode, isVerbose: isVerbose)
    }
    
    init(type: ExerciseType?, duration: Duration, mode: DurationView.Mode = .padded, isVerbose: Bool = false) {
        self.duration = type == .tabata ? .known(SettingsManager.shared.tabataExerciseDuration) : duration
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
                    Text("unknown")
                }
            }
        case .unlimited:
            HStack {
            LayoutUtils.unlimitedDurationImage
                if isVerbose {
                    Text("not limited")
                }
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
            ExerciseDurationView(for: ExerciseTemplate.surjaNamascar)
            
            Text("templates verbose")
            ExerciseDurationView(for: ExerciseTemplate.catCowNoType, isVerbose: true)
            ExerciseDurationView(for: ExerciseTemplate.catCowNoDuration, isVerbose: true)
            ExerciseDurationView(for: ExerciseTemplate.surjaNamascar, isVerbose: true)
            
            Text("exercises")
            ExerciseDurationView(for: Exercise.catCow)
        }
    }
}
