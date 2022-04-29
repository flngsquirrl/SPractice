//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Program {
    let id: UUID
    let name: String
    let exercises: Array<Exercise>
    
    static let personal = Program(id: UUID(), name: "Personal", exercises: [Exercise.catCow, Exercise.rest, Exercise.surjaNamascar, Exercise.rest, Exercise.vasihsthasana])
}
