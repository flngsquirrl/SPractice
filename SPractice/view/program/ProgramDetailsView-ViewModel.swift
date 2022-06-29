//
//  ProgramDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import Foundation

extension ProgramDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        var program: ProgramTemplate
        
        @Published var useRest: Bool = true
        
        @Published var showPracticeView = false
        @Published var showEditTemplateView = false
        
        init(for template: ProgramTemplate) {
            self.program = template
        }
        
        var practice: Program {
            Program(from: program, useRest: useRest)
        }
        
        func updateProgramTemplate(template: ProgramTemplate) {
            self.program = template
        }
    }
}
