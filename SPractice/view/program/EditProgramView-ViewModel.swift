//
//  EditProgramView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation
import SwiftUI

extension EditProgramView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var template: ProgramTemplate
        @Published var editMode: EditMode = .inactive
        
        init(template: ProgramTemplate) {
            self.template = template
        }
        
        var isSaveDisabled: Bool {
            !ValidationService.isValid(template)
        }
        
        var showExampleUpdateConfirmation: Bool {
            if template.isExample {
                let example = ProgramsManager.shared.getExample(exampleId: template.exampleId!)
                if let example = example {
                    if !template.isEqualToExample(example: example) {
                        return true
                    }
                }
            }
            
            return false
        }
        
        func prepareTemplate(markAsNonExample: Bool) -> ProgramTemplate {
            if markAsNonExample {
                template.isExample = false
            }
            return template
        }
    }
}
