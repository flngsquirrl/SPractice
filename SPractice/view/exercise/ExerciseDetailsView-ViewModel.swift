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
            self.tasks = Exercise(from: template)?.tasks ?? []
        }
        
        var showTasks: Bool {
            exercise.type == .tabata
        }
    }
}
