//
//  AddProgramView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation
import SwiftUI

extension AddProgramView {
    @MainActor class ViewModel: ObservableObject {

        @Published var newTemplate = ProgramTemplate.template
        @Published var editMode: EditMode = .inactive

        let programValidator = ProgramValidator()

        var isTemplateValid: Bool {
            programValidator.isValid(newTemplate)
        }

        var templateToSave: ProgramTemplate {
            var result = newTemplate
            result.trim()
            return result
        }

        var isAddDisabled: Bool {
            !programValidator.isValid(newTemplate)
        }
    }
}
