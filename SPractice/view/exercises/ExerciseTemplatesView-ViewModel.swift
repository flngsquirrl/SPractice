//
//  ExerciseTemplatesView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import Foundation

extension ExerciseTemplatesView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var templates = [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana, ExerciseTemplate.concentration, ExerciseTemplate.catCowDuration0]
        
        func addNewTemplate(template: ExerciseTemplate) {
            templates.append(template)
        }
        
        func removeItems(at offsets: IndexSet) {
            templates.remove(atOffsets: offsets)
        }
        
        func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
            templates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
        }
        
        func updateTemplate(template: ExerciseTemplate) {
            if let index = templates.firstIndex(where: {$0.id == template.id}) {
                templates[index] = template
            }
        }
    }
}
