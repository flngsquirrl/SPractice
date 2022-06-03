//
//  ProgramsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation

extension ProgramsView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var templates = [ProgramTemplate.personal, ProgramTemplate.dailyShort, ProgramTemplate.shortForBack]
        
        func addNewProgramTemplate(template: ProgramTemplate) {
            templates.append(template)
        }
        
        func removeItems(at offsets: IndexSet) {
            templates.remove(atOffsets: offsets)
        }
        
        func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
            templates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
        }
    }
}
