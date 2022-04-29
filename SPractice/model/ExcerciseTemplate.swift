//
//  ExcerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExcerciseTemplate {
    let id = UUID()
    var type: ExcerciseType
    var name: String
    var isService: Bool = false
    var duration: Int? // for timer only
}
