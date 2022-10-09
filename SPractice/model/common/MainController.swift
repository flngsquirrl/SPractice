//
//  MainController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.09.22.
//

import Foundation

@MainActor protocol MainController: ObservableObject, ResetableDataManager, SortableFilterableList, SortingSettingsManager
    where Item: HavingID {

    var newItem: UUID? {get set}
    var selected: Item? {get set}
    var searchText: String {get}

    func onAdd(_ item: Item)
    func onUpdate(_ item: Item)
    func onDelete(_ item: Item)
}

extension MainController {

    func onAdd(_ item: Item) {
        add(item)
        applySorting()
        newItem = item.id
    }

    func onUpdate(_ item: Item) {
        update(item)
        updateSelected(item)
    }

    func onDelete(_ item: Item) {
        delete(item)
        resetSelected(item)
    }

    private func updateSelected(_ item: Item) {
        if let selected {
            if item.id == selected.id {
                self.selected = item
            }
        }
    }

    private func resetSelected(_ item: Item) {
        if let selected {
            if item.id == selected.id {
                self.selected = nil
            }
        }
    }

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
