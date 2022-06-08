//
//  ExerciseTemplatesView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import Foundation

extension ExerciseTemplatesView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var templates = [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana, ExerciseTemplate.concentration]
        
        func addNewTemplate(template: ExerciseTemplate) {
            templates.append(template)
        }
        
        func removeItems(at offsets: IndexSet) {
            templates.remove(atOffsets: offsets)
        }
        
        func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
            templates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
        }
    }
}
