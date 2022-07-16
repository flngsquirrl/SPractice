//
//  ManagedList.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import Foundation

@MainActor protocol ManagedList {
    associatedtype Element: Named
    
    var searchText: String {get}
    
    var elements: [Element] {get}
    var sortProperty: SortProperty {get}
    var sortOrder: SortOrder {get}
    var filteredElements: [Element] {get}
    var sortedElements: [Element] {get}
}

protocol Named {
    var name: String {get}
}

extension ManagedList {
    var sortedElements: [Element] {
        let sorted: [Element]
        switch sortProperty {
        case .date:
            sorted = sortByDate()
        case .name:
            sorted = sortByName()
        }
        return sorted
    }
    
    func sortByDate() -> [Element] {
        var result: [Element]
        switch sortOrder {
        case .asc:
            result = filteredElements
        case .desc:
            result = filteredElements.reversed()
        }
        return result
    }
    
    func sortByName() -> [Element] {
        var result: [Element]
        switch sortOrder {
            case .asc:
                result = filteredElements.sorted(by: { $0.name < $1.name })
            case .desc:
                result = filteredElements.sorted(by: { $0.name > $1.name })
        }
        return result
    }
    
    var filteredElements: [Element] {
        if searchText.isEmpty {
            return elements
        } else {
            return elements.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func getSortedElement(index: Int) -> Element {
        sortedElements[index]
    }
}
