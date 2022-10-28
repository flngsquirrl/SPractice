//
//  ProgramsController.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

class ProgramsController: ResetableCollectionDataManager<ProgramTemplate>, ProgramsMainController, ProgramsMainManager {

    static var shared = ProgramsController()

    var dataManager = ProgramsPersistenceManager()

    @Published var searchText = ""
    var newItem: UUID?
    @Published var selected: ProgramTemplate?

    var sortingPropertyKey: String = "programsSortingProperty"
    var sortingOrderKey: String = "programsSortingOrder"

    var sortingProperty: SortingProperty = .date
    var sortingOrder: SortingOrder = .desc

    var isDataLoaded = false

    override init() {
        super.init()

        initialSetup()
    }
}
