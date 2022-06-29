//
//  ExerciseDurationView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.06.22.
//

import SwiftUI

struct ExerciseDurationView: View {
    
    enum Mode {
        case padded
        case extended
    }
    
    private let type: ExerciseType?
    private let duration: Int?
    private let mode: Mode
    
    init(for template: ExerciseTemplate, mode: Mode = .padded) {
        self.init(type: template.type, duration: template.duration, mode: mode)
    }
    
    init(for exercise: Exercise, mode: Mode = .padded) {
        self.init(type: exercise.type, duration: exercise.duration, mode: mode)
    }
    
    init(type: ExerciseType?, duration: Int? = nil, mode: Mode = .padded) {
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
                    if mode == .padded {
                        Text(ClockTime.getPaddedPresentation(for: duration))
                            .font(.system(.callout).monospacedDigit())
                    } else {
                        Text(ClockTime.getExtendedPresentation(for: duration))
                    }
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
