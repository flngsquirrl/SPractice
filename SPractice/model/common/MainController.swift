//
//  MainController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.09.22.
//

import Foundation

@MainActor protocol MainController: ObservableObject, ResetableDataManager, SortableFilterableList, SortingSettingsManager {
    var newItem: UUID? {get set}
    var selected: Item? {get set}
    var searchText: String {get}
}

extension MainController {

    var filteredItems: [Item] {
        filter(by: searchText)
    }

    func initialSetup() {
        readSortingSetup()
        applySorting()
    }

    func applySorting() {
        let sortedItems = sort()
        reset(to: sortedItems)
    }

    func setSorting() {
        applySorting()
        saveSorting()
    }
}
