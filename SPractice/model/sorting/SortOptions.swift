//
//  SortOptions.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import Foundation

@MainActor protocol SortingManager: AnyObject {
    var sortingPropertyKey: String {get}
    var sortingOrderKey: String {get}
    
    var sortingProperty: SortingProperty {get set}
    var sortingOrder: SortingOrder {get set}
}

extension SortingManager {
    
    func readSortingSetup() {
        readSortingProperty()
        readSortingOrder()
    }
    
    func readSortingProperty() {
        let savedValue = UserDefaults.standard.string(forKey: sortingPropertyKey)
        if let savedValue = savedValue {
            sortingProperty = SortingProperty(rawValue: savedValue)!
        } else {
            sortingProperty = .date
        }
    }
    
    func readSortingOrder() {
        let savedValue = UserDefaults.standard.string(forKey: sortingOrderKey)
        if let savedValue = savedValue {
            sortingOrder = SortingOrder(rawValue: savedValue)!
        } else {
            sortingOrder = .desc
        }
    }
    
    func saveSorting() {
        UserDefaults.standard.set(sortingProperty.rawValue, forKey: sortingPropertyKey)
        UserDefaults.standard.set(sortingOrder.rawValue, forKey: sortingOrderKey)
    }
}

enum SortingProperty: String, CaseIterable {
    case date = "creation time"
    case name = "name"
}

enum SortingOrder: String, CaseIterable {
    case asc = "ascending"
    case desc = "descending"
    
    var opposite: SortingOrder {
        if self == .asc {
            return .desc
        } else {
            return .asc
        }
    }
}
