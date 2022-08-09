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
        sort(filteredElements)
    }
        
    func sort(_ elements: [Element]) -> [Element] {
        let sorted: [Element]
        switch sortProperty {
        case .date:
            sorted = sortByDate(elements)
        case .name:
            sorted = sortByName(elements)
        }
        return sorted
    }
    
    func sortByDate(_ elements: [Element]) -> [Element] {
        var result: [Element]
        switch sortOrder {
        case .asc:
            result = elements
        case .desc:
            result = elements.reversed()
        }
        return result
    }
    
    func sortByName(_ elements: [Element]) -> [Element] {
        var result: [Element]
        switch sortOrder {
            case .asc:
                result = elements.sorted(by: { $0.name < $1.name })
            case .desc:
                result = elements.sorted(by: { $0.name > $1.name })
        }
        return result
    }
    
    var filteredElements: [Element] {
        filter(elements)
    }
    
    func filter(_ elements: [Element]) -> [Element] {
        if searchText.isEmpty {
            return elements
        } else {
            return elements.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func getSortedElement(index: Int) -> Element {
        sortedElements[index]
    }
    
    func getElement(index: Int) -> Element {
        elements[index]
    }
}
