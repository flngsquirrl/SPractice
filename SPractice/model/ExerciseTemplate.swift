//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: Identifiable {
    let id = UUID()
    var type: Exercise.ExerciseType
    var name: String
    var isService: Bool = false
    var duration: Int? // for timer only
    
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", duration: 90)
    static let surjaNamascar = ExerciseTemplate(type: .flow, name: "Surja Namascar")
}
