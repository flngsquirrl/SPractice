//
//  SortingSettingsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import Foundation

protocol SortingSettingsManager: AnyObject {
    var sortingPropertyKey: String {get}
    var sortingOrderKey: String {get}

    var sortingProperty: SortingProperty {get set}
    var sortingOrder: SortingOrder {get set}

    func saveSorting()
}

extension SortingSettingsManager {

    func readSortingSetup() {
        readSortingProperty()
        readSortingOrder()
    }

    func readSortingProperty() {
        let savedValue = UserDefaults.standard.string(forKey: sortingPropertyKey)
        if let savedValue {
            sortingProperty = SortingProperty(rawValue: savedValue)!
        } else {
            sortingProperty = .date
        }
    }

    func readSortingOrder() {
        let savedValue = UserDefaults.standard.string(forKey: sortingOrderKey)
        if let savedValue {
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
