//
//  PracticeProgram.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct PracticeProgram: Program {

    let id = UUID()
    var name: String = ""
    var description: String = ""
    var exercises: [PracticeExercise] = []

    var useRest: Bool = false

    var isExample: Bool = false
    var exampleId: String?

}
