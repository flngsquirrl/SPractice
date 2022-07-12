//
//  ContentView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.07.22.
//

import Foundation
import SwiftUI

extension ContentView {
    
    enum ContentType: String, CaseIterable {
        case programs = "Programs"
        case exercises = "Exercises"
    }
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var contentType: ContentType = .programs
        
        @AppStorage("exercisesSortProperty") var exercisesSortProperty: SortProperty = .date
        @AppStorage("exercisesSortOrder") var exercisesSortOrder: SortOrder = .desc
        
        @AppStorage("programsSortProperty") var programsSortProperty: SortProperty = .date
        @AppStorage("programsSortOrder") var programsSortOrder: SortOrder = .desc
        
        func isSortingSet(property: SortProperty, order: SortOrder) -> Bool {
            switch contentType {
            case .programs:
                return property == programsSortProperty && order == programsSortOrder
            case .exercises:
                return property == exercisesSortProperty && order == exercisesSortOrder
            }
        }
        
        func setSorting(property: SortProperty, order: SortOrder) {
            switch contentType {
            case .programs:
                programsSortProperty = property
                programsSortOrder = order
            case .exercises:
                exercisesSortProperty = property
                exercisesSortOrder = order
            }
        }
        
        func saveSettings() {
            SettingsManager.shared.saveSettings()
        }
    }
}
