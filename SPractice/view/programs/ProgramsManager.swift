//
//  ProgramsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

@MainActor class ProgramsManager: MainList {

    static let shared = ProgramsManager()

    var dataManager = Programs.shared
    var newItem: UUID?

    var sortingPropertyKey: String = "programsSortingProperty"
    var sortingOrderKey: String = "programsSortingOrder"
    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    @Published var items = Programs.shared.items
    var defaultExamples = ProgramTemplate.defaultExamples

    init() {
        initialSetup()
    }

    func prepareExample(from item: ProgramTemplate) -> ProgramTemplate {
        ProgramTemplate(from: item)
    }
}
