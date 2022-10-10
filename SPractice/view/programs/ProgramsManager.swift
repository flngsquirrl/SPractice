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

    var dataManager: ProgramsDataManager
    var controller: ProgramsController

    init() {
        dataManager = ProgramsDataManager()
        controller = ProgramsController(items: dataManager.list())
    }
}
