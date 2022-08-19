//
//  SortableFilterableList.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import Foundation

@MainActor protocol SortableFilterableList: SortableList, FilterableList {
}

@MainActor protocol SortableList: AnyObject {
    associatedtype Item: Named, HavingCreationDate
    
    var items: [Item] {get}
    
    var sortingProperty: SortingProperty {get}
    var sortingOrder: SortingOrder {get}
    
    func sort() -> [Item]
    func sort(_ items: [Item]) -> [Item]
}

@MainActor protocol FilterableList: AnyObject {
    associatedtype Item: Named
    
    var items: [Item] {get}
    
    func filter(by searchText: String) -> [Item]
    func filter(_ items: [Item], by searchText: String) -> [Item]
}

protocol Named {
    var name: String {get}
}

protocol HavingCreationDate {
    var creationDate: Date {get}
}

extension SortableList {
    
    func sort() -> [Item] {
        sort(items)
    }
    
    func sort(_ items: [Item]) -> [Item] {
        let sorted: [Item]
        switch sortingProperty {
        case .date:
            sorted = sortByDate(items)
        case .name:
            sorted = sortByName(items)
        }
        return sorted
    }
    
    private func sortByDate(_ items: [Item]) -> [Item] {
        var result: [Item]
        switch sortingOrder {
        case .asc:
            result = items.sorted(by: { $0.creationDate < $1.creationDate })
        case .desc:
            result = items.sorted(by: { $0.creationDate > $1.creationDate })
        }
        return result
    }
    
    private func sortByName(_ items: [Item]) -> [Item] {
        var result: [Item]
        switch sortingOrder {
        case .asc:
            result = items.sorted(by: { $0.name < $1.name })
        case .desc:
            result = items.sorted(by: { $0.name > $1.name })
        }
        return result
    }
}

extension FilterableList {
    
    func filter(_ items: [Item], by searchText: String) -> [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func filter(by searchText: String) -> [Item] {
        filter(items, by: searchText)
    }
    
}
