//
//  ExampleUtils.swift
//  SPractice
//
//  Created by Yuliya Charniak on 15.10.22.
//

import Foundation

enum ExampleUtils {

    static func isExample<T>(item: T) -> Bool {
        let example = item as? (any ExampleItem)
        return example?.isExample ?? false
    }
}
