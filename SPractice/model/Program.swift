//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Program {
    let id = UUID()
    var name: String
    var useRest: Bool = true
    var excercises: Array<Excercise>
    
    static let personal = Program(name: "Personal", useRest: true, excercises: [Excercise.catCow, Excercise.rest, Excercise.surjaNamascar, Excercise.rest, Excercise.vasihsthasana])
}
