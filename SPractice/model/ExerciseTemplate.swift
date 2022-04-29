//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate {
    let id = UUID()
    var type: ExerciseType
    var name: String
    var isService: Bool = false
    var duration: Int? // for timer only
}
