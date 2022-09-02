//
//  PersistentDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.08.22.
//

import Foundation

@MainActor protocol PersistentDataManager: DataManager {
    func save()
}

extension PersistentDataManager {
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

    func updateOrAdd(_ item: Item) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item
        } else {
            items.append(item)
        }
        save()
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
