//
//  ExerciseDurationView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.06.22.
//

import SwiftUI

struct ExerciseDurationView: View {
    
    private let type: ExerciseType?
    private let duration: Int?
    private let mode: DurationView.Mode
    
    init(for template: ExerciseTemplate, mode: DurationView.Mode = .padded) {
        self.init(type: template.type, duration: template.duration, mode: mode)
    }
    
    init(for exercise: Exercise, mode: DurationView.Mode = .padded) {
        self.init(type: exercise.type, duration: exercise.duration, mode: mode)
    }
    
    init(type: ExerciseType?, duration: Int? = nil, mode: DurationView.Mode = .padded) {
        self.type = type
        self.duration = duration == nil && type == .tabata ? SettingsManager.shared.tabataExerciseDuration : duration
        self.mode = mode
    }
    
    var body: some View {
        if let type = type {
            switch type {
            case .flow:
                Image(systemName: "infinity")
            case .timer, .tabata:
                if let duration = duration {
                    DurationView(duration: duration, mode: mode)
                } else {
                    Image(systemName: "questionmark")
                }
            }
        } else {
            Image(systemName: "questionmark")
        }
    }
}

struct ExerciseDurationView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDurationView(for: ExerciseTemplate.surjaNamascar)
        ExerciseDurationView(for: Exercise.catCow)
    }
}
