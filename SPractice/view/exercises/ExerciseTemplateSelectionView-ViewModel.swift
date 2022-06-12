//
//  ExerciseTemplateSelectionView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import Foundation

extension ExerciseTemplateSelectionView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var templates = [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana, ExerciseTemplate.concentration, ExerciseTemplate.catCowDuration0, ExerciseTemplate.catCowNoType]
        @Published var selections: [ExerciseTemplate] = []
        
        func onAdd(template: ExerciseTemplate) {
            selections.append(ExerciseTemplate(from: template))
        }
        
        func onDelete(template: ExerciseTemplate) {
            if let index = selections.firstIndex(of: template) {
                selections.remove(at: index)
            }
        }
        
        func removeItems(at offsets: IndexSet) {
            selections.remove(atOffsets: offsets)
        }
    }
}
