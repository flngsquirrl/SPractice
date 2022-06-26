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
    
    init(for template: Exercise) {
        self.init(type: template.type, duration: template.duration)
    }
    
    init(for exercise: PracticeExercise) {
        self.init(type: exercise.type, duration: exercise.duration)
    }
    
    init(type: ExerciseType?, duration: Int?) {
        self.type = type
        self.duration = duration
    }
    
    var body: some View {
        if let type = type {
            switch type {
            case .flow:
                Image(systemName: "infinity")
            case .timer, .tabata:
                if let duration = duration {
                    Text(ClockTime.getPaddedPresentation(for: duration))
                        .font(.system(.callout).monospacedDigit())
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
        ExerciseDurationView(for: Exercise.surjaNamascar)
        ExerciseDurationView(for: PracticeExercise.catCow)
    }
}
