//
//  ExerciseSelectionView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import Foundation
import SwiftUI

extension ExerciseSelectionView {
    @MainActor class ViewModel: ObservableObject, ManagedList {

        @AppStorage("exercisesSortProperty") internal var sortProperty: SortProperty = .date
        @AppStorage("exercisesSortOrder") internal var sortOrder: SortOrder = .desc
        
        typealias Element = SelectionItem
        
        @Published var itemsGroup: ItemsGroup = .all
        @Published var searchText = ""
        
        @Published var selectionItems: [SelectionItem] = Exercises.shared.items.map {SelectionItem(for: $0)}

        var elements: [SelectionItem] {
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
            for index in offsets {
                let item = getSortedElement(index: index)
                deleteSelectionItem(item)
            }
        }
        
        func deleteSelectionItem(_ item: SelectionItem) {
            if let itemIndex = selectionItems.firstIndex(where: { $0.id == item.id}) {
                selectionItems[itemIndex] = SelectionItem(for: item.template)
            }
        }
        
        func deleteFiltered() {
            for item in filteredElements {
                deleteSelectionItem(item)
            }
        }
        
        func onChange(_ item: SelectionItem, counter: Int) {
            if let itemIndex = selectionItems.firstIndex(where: { $0.id == item.id}) {
                selectionItems[itemIndex] = SelectionItem(for: item.template, counter: counter)
            }
        }
        
        var preparedNumber: Int {
            var number = 0
            selectionItems.forEach { number += $0.counter }
            return number
        }
        
        var exercises: [ExerciseTemplate] {
            var preparedExercises: [ExerciseTemplate] = []
            for item in selectionItems {
                if item.counter > 0 {
                    for _ in 0..<item.counter {
                        preparedExercises.append(ExerciseTemplate(from: item.template))
                    }
                }
            }
            return preparedExercises
        }
    }
}
