//
//  Filterable.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.10.22.
//

import Foundation

@MainActor protocol Filterable {

    associatedtype Item: Named

    func getItems() -> [Item]

    func filter(by searchText: String) -> [Item]
    func filter(_ items: [Item], by searchText: String) -> [Item]
}

extension Filterable {

    func filter(_ items: [Item], by searchText: String) -> [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func filter(by searchText: String) -> [Item] {
        filter(getItems(), by: searchText)
    }
}
