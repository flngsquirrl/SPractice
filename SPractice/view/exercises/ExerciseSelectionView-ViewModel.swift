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
        
        @Published var existingExercises = Exercises.shared.items
        @Published var preparedExercises: [ExerciseTemplate] = []
        
        @Published var searchText = ""

        var exercises: [ExerciseTemplate] {
            itemsGroup == .prepared ? preparedExercises : existingExercises
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
    }
}
