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
        
        @Published var useRest: Bool
        
        @Published var showPracticeView = false
        @Published var showEditTemplateView = false
        
        init(for template: ProgramTemplate) {
            self.template = template
            self.useRest = template.useRest
        }
        
        func onUseRestChange() {
            template.useRest.toggle()
        }
        
        func updateProgramTemplate(template: ProgramTemplate) {
            self.template = template
        }
        
        var isPracticeDisabled: Bool {
            !ValidationService.isValidToPractice(template: template)
        }
    }
}
