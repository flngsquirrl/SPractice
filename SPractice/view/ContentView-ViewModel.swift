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
        
        var sortProperty: SortProperty {
            switch contentType {
            case .programs:
                return programsSortProperty
            case .exercises:
                return exercisesSortProperty
            }
        }
        
        var sortOrder: SortOrder {
            switch contentType {
            case .programs:
                return programsSortOrder
            case .exercises:
                return exercisesSortOrder
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
            SettingsManager.saveSettings()
        }
    }
}
