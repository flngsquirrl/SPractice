//
//  SortingOptions.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.08.22.
//

import Foundation

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
