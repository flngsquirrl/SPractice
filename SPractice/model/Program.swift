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
    let excercises: Array<Excercise>
    
    static let personal = Program(id: UUID(), name: "Personal", excercises: [Excercise.catCow, Excercise.rest, Excercise.surjaNamascar, Excercise.rest, Excercise.vasihsthasana])
}
