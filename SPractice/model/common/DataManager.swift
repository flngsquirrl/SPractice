//
//  DataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.07.22.
//

import Foundation

@MainActor protocol DataManager: AnyObject {
    
    associatedtype Item: Identifiable
    
    var items: Array<Item> {get set}
    
    func addNew(_ item: Item)
    
    func update(_ item: Item)
    
    func delete(_ item: Item)
    
    func contains(_ item: Item) -> Bool
    
    func save()
}

extension DataManager {
    func addNew(_ item: Item) {
        items.append(item)
        save()
    }
    
    func update(_ item: Item) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item
            save()
        }
    }
    
    func delete(_ item: Item) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items.remove(at: index)
            save()
        }
    }
    
    func contains(_ item: Item) -> Bool {
        items.firstIndex(where: {$0.id == item.id}) != nil
    }
}
