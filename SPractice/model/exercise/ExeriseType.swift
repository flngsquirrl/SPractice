//
//  ExeriseType.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

enum ExerciseType: String, CaseIterable, Codable {
    case flow
    case timer
    case tabata
    
    var hasDuration: Bool {
        self != .flow
    }
}
