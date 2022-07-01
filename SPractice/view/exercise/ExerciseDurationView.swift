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
    
    init(for template: ExerciseTemplate, mode: DurationView.Mode = .padded) {
        self.init(type: template.type, duration: template.duration, mode: mode)
    }
    
    init(for exercise: Exercise, mode: DurationView.Mode = .padded) {
        self.init(type: exercise.type, duration: exercise.duration, mode: mode)
    }
    
    init(type: ExerciseType?, duration: Duration, mode: DurationView.Mode = .padded) {
        self.duration = type == .tabata ? .known(SettingsManager.shared.tabataExerciseDuration) : duration
        self.mode = mode
    }
    
    var body: some View {
        switch duration {
        case .known(let time):
            DurationView(duration: time, mode: mode)
        case .unknown:
            LayoutUtils.unknownDurationImage
        case .unlimited:
            LayoutUtils.unlimitedDurationImage
        }
    }
}

struct ExerciseDurationView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDurationView(for: ExerciseTemplate.surjaNamascar)
        ExerciseDurationView(for: Exercise.catCow)
    }
}
