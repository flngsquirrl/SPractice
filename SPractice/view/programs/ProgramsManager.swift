//
//  ProgramsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

class ProgramsManager: MainManager {
    typealias Item = ProgramTemplate

    static let shared = ProgramsManager()

    var dataManager: ProgramsPersistenceManager
    var controller: ProgramsController

    init() {
        dataManager = ProgramsPersistenceManager()
        controller = ProgramsController(items: dataManager.list())
    }
}
