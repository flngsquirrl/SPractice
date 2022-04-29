//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ProgramTemplate {
    let id = UUID()
    var name: String
    var useRest: Bool = true
    var exercises: Array<Exercise>
}
