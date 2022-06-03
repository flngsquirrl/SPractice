//
//  NewExerciseView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation

extension NewExerciseView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var name: String = ""
        @Published var type: Exercise.ExerciseType = .timer
        @Published var minutes: Int = 1
        @Published var seconds: Int = 0
        
        func prepareNewExerciseTemplate() -> ExerciseTemplate {
            let duration = type == .timer ? Clock.calculateDuration(minutes: minutes, seconds: seconds) : nil
            return ExerciseTemplate(type: type, name: name, duration: duration)
        }
    }
}
