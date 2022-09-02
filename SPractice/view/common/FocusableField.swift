//
//  FocusableField.swift
//  SPractice
//
//  Created by Yuliya Charniak on 15.08.22.
//

import Foundation

enum FocusableField {
    case name
    case description

    static func moveFocusFrom(field: FocusableField?) -> FocusableField? {
        if field == .name {
            return .description
        }

        return nil
    }
}
