//
//  ProgramsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

@MainActor class ProgramsManager: MainManager {
    typealias Item = ProgramTemplate

    static let shared = ProgramsManager()

    var controller: ProgramsController
    var dataManager: Programs

    init() {
        dataManager = Programs.shared
        controller = ProgramsController(items: Programs.shared.items)
    }
}
