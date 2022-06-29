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
        
        @Published var existingExercises = ExercisesManager.shared.exercises
        @Published var preparedExercises: [ExerciseTemplate] = []
        
        @Published var searchText = ""

        var filteredExercises: [ExerciseTemplate] {
            let target = itemsGroup == .selected ? preparedExercises : existingExercises
            if searchText.isEmpty {
                return target
            } else {
                return target.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        func onAdd(template: ExerciseTemplate) {
            preparedExercises.append(ExerciseTemplate(from: template))
        }
        
        func onDelete(template: ExerciseTemplate) {
            if let index = preparedExercises.firstIndex(of: template) {
                preparedExercises.remove(at: index)
            }
        }
        
        func removeItems(at offsets: IndexSet) {
            preparedExercises.remove(atOffsets: offsets)
        }
        
        func deleteFiltered() {
            for exercise in filteredExercises {
                onDelete(template: exercise)
            }
        }
    }
}
