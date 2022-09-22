//
//  ProgramsController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

@MainActor class ProgramsController: MainController {

    @Published var searchText = ""

    var sortingPropertyKey: String = "programsSortingProperty"
    var sortingOrderKey: String = "programsSortingOrder"

    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    var newItem: UUID?
    @Published var selected: ProgramTemplate?
    @Published var items: [ProgramTemplate]

    init(items: [ProgramTemplate]) {
        self.items = items
        initialSetup()
    }

}
