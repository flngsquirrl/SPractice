//
//  ProgramsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.08.22.
//

import Foundation

extension ProgramsView {
    @MainActor class ViewModel: MainList {
        
        static let shared = ViewModel()
        
        typealias Element = ProgramTemplate
        
        var dataManager = Programs.shared
        var newItem: UUID?
        
        @Published var searchText = ""
        
        var sortingPropertyKey: String = "programsSortingProperty"
        var sortingOrderKey: String = "programsSortingOrder"
        var sortingProperty: SortingProperty = .date
        var sortingOrder: SortingOrder = .desc
        
        @Published var items = Programs.shared.items
        
        init() {
            initialSetup()
        }
        
        var programs: [ProgramTemplate] {
            filteredElements
        }
    }
}
