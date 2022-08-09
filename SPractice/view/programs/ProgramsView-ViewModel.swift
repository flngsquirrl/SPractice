//
//  ProgramsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

extension ProgramsView {
    @MainActor class ViewModel: MainList {
        
        typealias Element = ProgramTemplate
        
        var dataManager = Programs.shared
        var selectionManager = ProgramSelectionManager.shared
        
        @Published var searchText = ""
        
        var sortPropertyKey: String = "programsSortProperty"
        var sortOrderKey: String = "programsSortOrder"
        var sortProperty: SortProperty = .date
        var sortOrder: SortOrder = .desc
        
        @Published var items = Programs.shared.items
        
        init() {
            initialSetup()
        }
        
        var programs: [ProgramTemplate] {
            filteredElements
        }
    }
}
