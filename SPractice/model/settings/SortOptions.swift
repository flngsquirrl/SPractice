//
//  SortOptions.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import Foundation

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
