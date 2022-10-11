//
//  ProgramsController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

class ProgramsController: ResetableCollectionDataManager<ProgramTemplate>, ProgramsMainController,
    ProgramsMainManager {

    static var shared = ProgramsController()

    var persistenceManager = ProgramsPersistenceManager()

    @Published var searchText = ""

    var sortingPropertyKey: String = "programsSortingProperty"
    var sortingOrderKey: String = "programsSortingOrder"

    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    var newItem: UUID?
    @Published var selected: ProgramTemplate?

    var isLoaded = false

    func getItems() -> [ProgramTemplate] {
        if !isLoaded {
            add(persistenceManager.list())
            isLoaded = true
        }

        return list()
    }
}
