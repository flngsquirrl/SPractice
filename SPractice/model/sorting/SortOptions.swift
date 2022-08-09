//
//  SortOptions.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import Foundation

@MainActor protocol SortingManager: AnyObject {
    var sortPropertyKey: String {get}
    var sortOrderKey: String {get}
    
    var sortProperty: SortProperty {get set}
    var sortOrder: SortOrder {get set}
}

extension SortingManager {
    
    func readSortSetup() {
        readSortProperty()
        readSortOrder()
    }
    
    func readSortProperty() {
        let savedValue = UserDefaults.standard.string(forKey: sortPropertyKey)
        if let savedValue = savedValue {
            sortProperty = SortProperty(rawValue: savedValue)!
        }
    }
    
    func readSortOrder() {
        let savedValue = UserDefaults.standard.string(forKey: sortOrderKey)
        if let savedValue = savedValue {
            sortOrder = SortOrder(rawValue: savedValue)!
        }
    }
    
    func saveSorting() {
        UserDefaults.standard.set(sortProperty.rawValue, forKey: sortPropertyKey)
        UserDefaults.standard.set(sortOrder.rawValue, forKey: sortOrderKey)
    }
}

enum SortProperty: String, CaseIterable {
    case date = "creation time"
    case name = "name"
}

enum SortOrder: String, CaseIterable {
    case asc = "ascending"
    case desc = "descending"
    
    var opposite: SortOrder {
        if self == .asc {
            return .desc
        } else {
            return .asc
        }
    }
}
