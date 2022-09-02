//
//  ExerciseContentsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.06.22.
//

import Foundation

extension ExerciseContentsView {
    @MainActor class ViewModel: ObservableObject {

        @Published var exercise: ExerciseTemplate

        init(for template: ExerciseTemplate) {
            self.exercise = template
        }

        var showTasks: Bool {
            exercise.isTypeSet && exercise.type == .tabata
        }

        var tasks: [Task] {
            PracticeExercise(from: exercise)!.tasks
        }
    }
}
