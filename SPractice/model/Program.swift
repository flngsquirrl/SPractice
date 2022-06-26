//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct Program: Identifiable {
    
    let id: UUID
    var name: String
    var exercises = [Exercise]()
    
    init(id: UUID = UUID(), name: String = "", exercises: [Exercise] = []) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
    
    var hasExercises: Bool {
        !exercises.isEmpty
    }
    
    static var defaultTemplate = Program()
    
    // examples
    static let personal = Program(name: "Personal", exercises: [Exercise.catCow, Exercise.surjaNamascar, Exercise.vasihsthasana])
    static let dailyShort = Program(name: "Daily short", exercises: [Exercise.concentration, Exercise.catCow])
    static let shortForBack = Program(name: "Short for back", exercises: [Exercise.catCow])
}
