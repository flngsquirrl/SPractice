//
//  ExerciseTemplateDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.06.22.
//

import Foundation

extension ExerciseDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var exercise: ExerciseTemplate
        @Published var tasks: [Task] = []
        
        init(for template: ExerciseTemplate) {
            self.exercise = template
            self.tasks = PracticeExercise(from: template)?.tasks ?? []
        }
        
        var showTasks: Bool {
            showDetails && exercise.type == .tabata
        }
        
        var showDetails: Bool {
            exercise.isTypeSet
        }
    }
}
