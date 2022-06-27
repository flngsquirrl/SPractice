//
//  ProgramDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import Foundation

extension ProgramDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        var program: Program
        
        @Published var useRest: Bool = true
        
        @Published var showPracticeView = false
        @Published var showEditTemplateView = false
        
        init(for template: Program) {
            self.program = template
        }
        
        var practice: PracticeProgram {
            PracticeProgram(from: program, useRest: useRest)
        }
        
        func updateProgramTemplate(template: Program) {
            self.program = template
        }
    }
}
