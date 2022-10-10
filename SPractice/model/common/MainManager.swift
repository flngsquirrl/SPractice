//
//  MainManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.08.22.
//

import SwiftUI

protocol MainManager: ObservableObject {

    associatedtype Item

    associatedtype MainDataManager: DataManager where MainDataManager.Item == Self.Item, MainDataManager.Item: HavingID
    associatedtype MainDataController: MainController where MainDataController.Item == Self.Item

    var dataManager: MainDataManager {get}
    var controller: MainDataController {get}

    func addItem(_ item: Item)
    func updateItem(_ item: Item)
    func deleteItem(_ item: Item)
    func listItems() -> [Item]
}

protocol HavingID: Identifiable where Self.ID == UUID {}

extension MainManager {

    func addItem(_ item: Item) {
        controller.onAdd(item)
        dataManager.add(item)
    }

    func updateItem(_ item: Item) {
        controller.onUpdate(item)
        dataManager.update(item)
    }

    func deleteItem(_ item: Item) {
        controller.onDelete(item)
        dataManager.delete(item)
    }

    func listItems() -> [Item] {
        dataManager.list()
    }
}
