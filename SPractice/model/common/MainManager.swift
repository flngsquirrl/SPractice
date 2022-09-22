//
//  MainManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.08.22.
//

import SwiftUI

@MainActor protocol MainManager: ObservableObject, ExamplesManager {

    associatedtype MainDataManager: PersistentDataManager where MainDataManager.Item == Self.Item
    associatedtype MainDataController: MainController where MainDataController.Item == Self.Item

    var dataManager: MainDataManager {get}
    var controller: MainDataController {get}

    func addItem(_ item: Item)
    func updateItem(_ item: Item)
    func deleteItem(_ item: Item)
}

extension MainManager {

    func addItem(_ item: Item) {
        controller.addNew(item)
        controller.applySorting()
        controller.newItem = item.id

        dataManager.addNew(item)
    }

    func updateItem(_ item: Item) {
        controller.update(item)
        updateSelected(item)

        dataManager.update(item)
    }

    private func updateSelected(_ item: Item) {
        if let selected = controller.selected {
            if item.id == selected.id {
                controller.selected = item
            }
        }
    }

    private func resetSelected(_ item: Item) {
        if let selected = controller.selected {
            if item.id == selected.id {
                controller.selected = nil
            }
        }
    }

    func deleteItem(_ item: Item) {
        controller.delete(item)
        resetSelected(item)

        dataManager.delete(item)
    }

    func isExampleExist(exampleId: String) -> Bool {
        controller.items.contains {$0.exampleId == exampleId}
    }

    func getExample(exampleId: String) -> Item? {
        controller.items.first {$0.exampleId == exampleId}
    }

    func restoreExample(_ item: Item) {
        addItem(Self.Item.prepareExample(from: item))
    }

    func resetExample(_ item: Item) {
        updateItem(item)
    }
}
