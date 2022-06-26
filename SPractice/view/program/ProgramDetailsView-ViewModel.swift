//
//  ProgramDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import Foundation

extension ProgramDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        var template: Program
        
        @Published var useRest: Bool = true
        
        @Published var showPracticeView = false
        @Published var showEditTemplateView = false
        
        init(for template: Program) {
            self.template = template
        }
        
        var program: PracticeProgram {
            PracticeProgram(from: template, useRest: useRest)
        }
        
        func updateProgramTemplate(template: Program) {
            self.template = template
        }
    }
}
