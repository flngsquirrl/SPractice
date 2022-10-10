//
//  ProgramsController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

class ProgramsController: ResetableCollectionDataManager<ProgramTemplate>, MainList {

    @Published var searchText = ""

    var sortingPropertyKey: String = "programsSortingProperty"
    var sortingOrderKey: String = "programsSortingOrder"

    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    var newItem: UUID?
    @Published var selected: ProgramTemplate?

    init(items: [ProgramTemplate]) {
        super.init()

        add(items)
        initialSetup()
    }

    func getItems() -> [ProgramTemplate] {
        list()
    }
}
