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
        
        init(for template: ExerciseTemplate) {
            self.exercise = template
        }
        
        var showTasks: Bool {
            showDetails && exercise.type == .tabata
        }
        
        var tasks: [Task] {
            PracticeExercise(from: exercise)?.tasks ?? []
        }
        
        var showDetails: Bool {
            exercise.isTypeSet
        }
        
        var showDescription: Bool {
            !exercise.description.isEmptyString
        }
    }
}
