//
//  DataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.07.22.
//

import Foundation

protocol DataManager {

    associatedtype Item

    func add(_ item: Item)
    func add(_ items: [Item])

    func update(_ item: Item)

    func updateOrAdd(_ item: Item)

    func delete(_ item: Item)

    func contains(_ item: Item) -> Bool

    func list() -> [Item]
}

protocol ResetableDataManager: DataManager {

    func reset(to items: [Item])
}

class CollectionDataManager<T: Identifiable>: DataManager, ObservableObject {

    @Published fileprivate var items = [T]()

    func add(_ item: T) {
        items.append(item)
    }

    func add(_ items: [T]) {
        self.items.append(contentsOf: items)
    }

    func update(_ item: T) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item
        }
    }

    func updateOrAdd(_ item: T) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item
        } else {
            items.append(item)
        }
    }

    func delete(_ item: T) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items.remove(at: index)
        }
    }

    func contains(_ item: T) -> Bool {
        items.firstIndex(where: {$0.id == item.id}) != nil
    }

    func list() -> [T] {
        items
    }
}

class ResetableCollectionDataManager<T: Identifiable>: CollectionDataManager<T>, ResetableDataManager {
    func reset(to items: [T]) {
        self.items = items
    }
}
