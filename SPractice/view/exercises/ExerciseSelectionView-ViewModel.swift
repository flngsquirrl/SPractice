//
//  ExerciseSelectionView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import Foundation
import SwiftUI

extension ExerciseSelectionView {
    @MainActor class ViewModel: ObservableObject, SortableFilterableList {

        @AppStorage("exercisesSortingProperty") internal var sortingProperty: SortingProperty = .date
        @AppStorage("exercisesSortingOrder") internal var sortingOrder: SortingOrder = .desc
        
        @Published var itemsGroup: ItemsGroup = .all
        @Published var searchText = ""
        
        @Published var selectionItems: [SelectionItem] = Exercises.shared.items.map {SelectionItem(for: $0)}
        
        var sortedElements: [Item] {
            sort(filteredElements)
        }
        
        var filteredElements: [Item] {
            filter(by: searchText)
        }
        
        func getSortedElement(index: Int) -> Item {
            sortedElements[index]
        }

        var items: [SelectionItem] {
            if itemsGroup == .prepared {
                return selectionItems.filter {$0.counter != 0}
            }
            return selectionItems
        }
        
        var headerText: String {
            if itemsGroup == .prepared {
                return "\(itemsGroup.rawValue.uppercased()) (\(preparedNumber))"
            } else {
                return "\(itemsGroup.rawValue.uppercased())"
            }
        }
        
        func onDeleteSelectionItem(at offsets: IndexSet) {
            objectWillChange.send()
            
            for index in offsets {
                let item = getSortedElement(index: index)
                deleteSelectionItem(item)
            }
        }
        
        func deleteSelectionItem(_ item: SelectionItem) {
            if let item = selectionItems.first(where: { $0.id == item.id}) {
                item.counter = 0
            }
        }
        
        func deleteFiltered() {
            objectWillChange.send()
            for item in filteredElements {
                deleteSelectionItem(item)
            }
        }
        
        func onChange() {
            objectWillChange.send()
        }
        
        var preparedNumber: Int {
            var number = 0
            selectionItems.forEach { number += $0.counter }
            return number
        }
        
        var preparedItems: [SelectionItem] {
            return selectionItems.filter { $0.counter > 0 }
        }
        
        var preparedExercisesCount: Int {
            var counter = 0
            preparedItems.forEach {
                counter += $0.counter
            }
            return counter
        }
        
        var preparedExercises: [ExerciseTemplate] {
            var preparedExercises: [ExerciseTemplate] = []
            
            let preparedItems = sort(preparedItems)
            
            preparedItems.forEach {
                for _ in 0..<$0.counter {
                    preparedExercises.append(ExerciseTemplate(from: $0.template))
                }
            }
            return preparedExercises
        }
        
        var isAddDisabled: Bool {
            preparedExercisesCount == 0
        }
    }
}
