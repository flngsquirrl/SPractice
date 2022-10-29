//
//  Sortable.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import Foundation

@MainActor protocol Sortable {
    associatedtype Item: Named, Created

    var items: [Item] {get}

    var sortingProperty: SortingProperty {get}
    var sortingOrder: SortingOrder {get}

    func sort() -> [Item]
    func sort(_ items: [Item]) -> [Item]
}

protocol Named {
    var name: String {get}
}

protocol Created {
    var creationDate: Date {get}
}

extension Sortable {

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
            result = items.sorted(by: { $0.name.localizedStandardCompare($1.name) == .orderedAscending })
        case .desc:
            result = items.sorted(by: { $0.name.localizedStandardCompare($1.name) == .orderedDescending })
        }
        return result
    }
}
