//
//  MainController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.09.22.
//

import Foundation

protocol HavingID: Identifiable where Self.ID == UUID {}

typealias ManagedItem = HavingID & Named & Created
typealias SortableFilterable = Sortable & Filterable

@MainActor protocol StateController: SortableFilterable, ResetableDataManager, SortingSettingsManager where Item: ManagedItem {

    var newItem: UUID? {get set}
    var selected: Item? {get set}
    var searchText: String {get}

    var filteredItems: [Item] {get}

    func setSorting()
}

typealias MainController = MainManager & StateController

@MainActor protocol BasicMainController: MainController {

    associatedtype MainDataManager: DataManager where MainDataManager.Item == Self.Item

    var persistenceManager: MainDataManager {get set}
    func initialSetup()
}

extension BasicMainController {

    func addItem(_ item: Item) {
        onAdd(item)
        persistenceManager.add(item)
    }

    func updateItem(_ item: Item) {
        onUpdate(item)
        persistenceManager.update(item)
    }

    func deleteItem(_ item: Item) {
        onDelete(item)
        persistenceManager.delete(item)
    }

    func listItems() -> [Item] {
        persistenceManager.list()
    }

    private func onAdd(_ item: Item) {
        add(item)
        applySorting()
        newItem = item.id
    }

    private func onUpdate(_ item: Item) {
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

    private func applySorting() {
        let sortedItems = sort()
        reset(to: sortedItems)

        saveSorting()
    }

    func setSorting() {
        applySorting()
        saveSorting()
    }
}

@MainActor protocol ExercisesMainController: BasicMainController where Item == ExerciseTemplate {}
@MainActor protocol ProgramsMainController: BasicMainController where Item == ProgramTemplate {}
