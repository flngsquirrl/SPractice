//
//  ExerciseTemplateDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.06.22.
//

import Foundation

extension ExerciseDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var exercise: Exercise
        @Published var tasks: [Task] = []
        
        init(for template: Exercise) {
            self.exercise = template
            self.tasks = PracticeExercise(from: template)?.tasks ?? []
        }
    }
}
