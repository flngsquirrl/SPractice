//
//  ExerciseSelectionView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import Foundation
import SwiftUI

extension ExerciseSelectionView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var itemsGroup: ItemsGroup = .all
        
        @Published var templates = [Exercise.catCow, Exercise.surjaNamascar, Exercise.vasihsthasana, Exercise.concentration, Exercise.catCowDurationNoDuration, Exercise.catCowNoType]
        @Published var selections: [Exercise] = []
        
        @Published var searchText = ""

        var searchableTemplates: [Exercise] {
            let target = itemsGroup == .selected ? selections : templates
            if searchText.isEmpty {
                return target
            } else {
                return target.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        init() {
            for _ in 1...100 {
                templates.append(Exercise(from: Exercise.catCow))
            }
        }
        
        func onAdd(template: Exercise) {
            selections.append(Exercise(from: template))
        }
        
        func onDelete(template: Exercise) {
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
