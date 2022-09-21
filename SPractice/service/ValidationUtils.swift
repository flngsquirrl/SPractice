//
//  ValidationUtils.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

enum ValidationUtils {

    static func isNameValid(_ name: String) -> Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
