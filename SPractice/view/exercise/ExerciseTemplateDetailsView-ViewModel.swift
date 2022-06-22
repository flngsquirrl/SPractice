//
//  ExerciseTemplateDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.06.22.
//

import Foundation

extension ExerciseTemplateDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var template: ExerciseTemplate
        @Published var tasks: [Task] = []
        
        init(for template: ExerciseTemplate) {
            self.template = template
            self.tasks = Exercise(from: template)?.tasks ?? []
        }
        
        
    }
}
