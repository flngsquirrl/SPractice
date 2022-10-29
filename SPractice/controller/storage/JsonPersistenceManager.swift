//
//  JsonPersistentDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.08.22.
//

import Foundation

protocol Persisting {

    associatedtype Item

    func load() -> [Item]
    func save(_ items: [Item])
}

protocol JsonPersisting: Persisting where Item: Codable {

    func getFileName() -> String
}

protocol DefaultItemsProvider {

    associatedtype Item

    func getDefaultItems() -> [Item]
}

extension JsonPersisting {

    var savePath: URL {
        let fileName = getFileName()
        return FileManager.documentsDirectory.appendingPathComponent(fileName)
    }

    func load() -> [Item] {
        var items = [Item]()

        let data = try? Data(contentsOf: savePath)
        do {
            if let data {
                items = try JSONDecoder().decode([Item].self, from: data)
            }
        } catch {
            print("Failed to read data from \(savePath)")
        }
        return items
    }

    func save(_ items: [Item]) {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data to \(savePath)")
        }
    }
}

typealias JsonItem = Identifiable & Codable

protocol DefaultItemsProviding {

    associatedtype Item

    var defaultItems: [Item] {get}
}

class JsonPersistenceManager<T: JsonItem>: CollectionDataManager<T>, JsonPersisting, DefaultItemsProviding {

    typealias Item = T

    var defaultItems: [T] {
        [T]()
    }

    override init() {
        super.init()

        var items = load()
        if items.isEmpty {
            items = defaultItems
        }
        add(items)
    }

    override func add(_ item: T) {
        super.add(item)
        save()
    }

    override func add(_ items: [T]) {
        super.add(items)
        save()
    }

    override func update(_ item: T) {
        super.update(item)
        save()
    }

    override func updateOrAdd(_ item: T) {
        super.updateOrAdd(item)
        save()
    }

    override func delete(_ item: T) {
        super.delete(item)
        save()
    }

    func save() {
        save(list())
    }

    func getFileName() -> String {
        "\(type(of: self))"
    }

    func getDefaultItems() -> [T] {
        [T]()
    }
}
