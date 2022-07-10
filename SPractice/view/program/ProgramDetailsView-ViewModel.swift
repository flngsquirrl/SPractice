//
//  ProgramDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import Foundation

extension ProgramDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var template: ProgramTemplate
        
        @Published var showPracticeView = false
        @Published var showEditTemplateView = false
        
        init(for template: ProgramTemplate) {
            self.template = template
        }
        
        func updateProgramTemplate(template: ProgramTemplate) {
            self.template = template
        }
        
        var preparedProgram: PreparedProgram {
            PreparedProgram(from: template)
        }
        
        var isPracticeDisabled: Bool {
            !ValidationService.isValidToPractice(template: template)
        }
    }
}
