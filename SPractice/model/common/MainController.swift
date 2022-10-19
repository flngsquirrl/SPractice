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
    var searchText: String {get set}
}

typealias MainController = MainManager & StateController

@MainActor protocol MainDataController: MainController {

    associatedtype MainDataManager: DataManager where MainDataManager.Item == Self.Item

    var dataManager: MainDataManager {get set}
    var isDataLoaded: Bool {get set}

    var filteredItems: [Item] {get}

    func setSorting()
    func initialSetup()
}

extension MainDataController {

    func addItem(_ item: Item) {
        onAdd(item)
        dataManager.add(item)
    }

    func updateItem(_ item: Item) {
        onUpdate(item)
        dataManager.update(item)
    }

    func deleteItem(_ item: Item) {
        onDelete(item)
        dataManager.delete(item)
    }

    func listItems() -> [Item] {
        dataManager.list()
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

    private func applySorting() {
        let sortedItems = sort()
        reset(to: sortedItems)

        saveSorting()
    }

    func setSorting() {
        applySorting()
        saveSorting()
    }

    var items: [Item] {
        if !isDataLoaded {
            let items = dataManager.list()
            add(items)

            isDataLoaded = true
        }

        return list()
    }

    func initialSetup() {
        readSortingSetup()
        applySorting()
    }
}

@MainActor protocol ExercisesDataController: MainDataController where Item == ExerciseTemplate {}
@MainActor protocol ProgramsDataController: MainDataController where Item == ProgramTemplate {}

typealias Controller = MainDataController & MainManager
