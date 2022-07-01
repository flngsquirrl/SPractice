//
//  ProgramDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import Foundation

extension ProgramDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        var template: ProgramTemplate
        
        @Published var useRest: Bool = true
        
        @Published var showPracticeView = false
        @Published var showEditTemplateView = false
        
        init(for template: ProgramTemplate) {
            self.template = template
        }
        
        var programTemplate: ProgramTemplate {
            ProgramTemplate(from: template, useRest: useRest)
        }
        
        func updateProgramTemplate(template: ProgramTemplate) {
            self.template = template
        }
    }
}
