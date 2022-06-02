//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ProgramTemplate: Identifiable {
    
    let id = UUID()
    var name: String
    var useRest: Bool = true
    var exercises = [ExerciseTemplate]()
    
    static let personal = ProgramTemplate(name: "Personal", exercises: [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana])
    static let dailyShort = ProgramTemplate(name: "Daily short", exercises: [ExerciseTemplate.concentration, ExerciseTemplate.catCow])
    static let shortForBack = ProgramTemplate(name: "Short for back", exercises: [ExerciseTemplate.catCow])
}
