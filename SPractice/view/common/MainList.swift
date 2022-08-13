//
//  MainList.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.08.22.
//

import SwiftUI

@MainActor protocol MainList: ObservableObject, ManagedList, ListWithExamples, DataManager, SortingManager where Self.Element == Self.Item {
    
    associatedtype ListDataManager: PersistentDataManager where ListDataManager.Item == Self.Item
    
    var newItem: UUID? {get set}
   
    var dataManager: ListDataManager {get}
}

extension MainList {
    
    func initialSetup() {
        readSortingSetup()
        applySorting()
    }
    
    var elements: [Item] {
        items
    }
    
    func applySorting() {
        items = sort(items)
    }
    
    func setSorting() {
        applySorting()
        saveSorting()
    }
    
    func addItem(_ item: Item) {
        addNew(item)
        applySorting()
        
        dataManager.addNew(item)
        newItem = item.id
    }
    
    func updateItem(_ item: Item) {
        update(item)
        dataManager.update(item)
    }
    
    func deleteItem(_ item: Item) {
        delete(item)
        dataManager.delete(item)
    }
    
    func isExampleExist(exampleId: String) -> Bool {
        items.contains {$0.exampleId == exampleId}
    }
    
    func getExample(exampleId: String) -> Item? {
        items.first {$0.exampleId == exampleId}
    }
    
    func restoreExample(_ item: Item) {
        addItem(prepareExample(from: item))
    }
    
    func resetExample(_ item: Item) {
        updateItem(item)
    }
}
