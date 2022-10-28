//
//  SortingOptions.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.08.22.
//

import Foundation

enum SortingProperty: String, CaseIterable {
    case date
    case name
}

enum SortingOrder: String, CaseIterable {
    case asc
    case desc

    var opposite: SortingOrder {
        if self == .asc {
            return .desc
        } else {
            return .asc
        }
    }
}
