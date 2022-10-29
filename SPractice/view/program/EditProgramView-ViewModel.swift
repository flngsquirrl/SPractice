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

        let programValidator = ProgramValidator()
        var programExamplesManager = ProgramExamplesManager()

        init(template: ProgramTemplate) {
            self.template = template
        }

        var isSaveDisabled: Bool {
            !programValidator.isValid(template)
        }

        var showExampleUpdateConfirmation: Bool {
            if template.isExample {
                let example = programExamplesManager.getExample(exampleId: template.exampleId!)
                if let example = example {
                    if !template.isEqualToExample(example: example) {
                        return true
                    }
                }
            }

            return false
        }

        func prepareTemplate(markAsNonExample: Bool) -> ProgramTemplate {
            var result = template
            result.trim()
            if markAsNonExample {
                result.isExample = false
            }
            return result
        }
    }
}
