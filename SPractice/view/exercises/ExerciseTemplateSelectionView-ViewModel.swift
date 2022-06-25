//
//  ExerciseTemplateSelectionView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import Foundation
import SwiftUI

extension ExerciseTemplateSelectionView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var templatesGroup: TemplatesGroup = .all
        
        @Published var templates = [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana, ExerciseTemplate.concentration, ExerciseTemplate.catCowDurationNoDuration, ExerciseTemplate.catCowNoType]
        @Published var selections: [ExerciseTemplate] = []
        
        @Published var searchText = ""

        var searchableTemplates: [ExerciseTemplate] {
            let target = templatesGroup == .selected ? selections : templates
            if searchText.isEmpty {
                return target
            } else {
                return target.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        init() {
            for _ in 1...100 {
                templates.append(ExerciseTemplate(from: ExerciseTemplate.catCow))
            }
        }
        
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
        
        func clearSelections() {
            selections.removeAll()
        }
    }
}
