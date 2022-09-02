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

        var isTemplateValid: Bool {
            ValidationService.isValid(newTemplate)
        }

        var isAddDisabled: Bool {
            !ValidationService.isValid(newTemplate)
        }
    }
}
