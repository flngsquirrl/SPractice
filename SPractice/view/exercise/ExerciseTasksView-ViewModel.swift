//
//  ExerciseTasksView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.10.22.
//

import Foundation

extension ExerciseTasksView {
    @MainActor class ViewModel: ObservableObject {

        let practiceService = PracticeService()

        let exercise: ExerciseTemplate

        init(exercise: ExerciseTemplate) {
            self.exercise = exercise
        }

        var tasks: [Task] {
            return practiceService.prepareForPractice(exercise)?.tasks ?? []
        }
    }
}
