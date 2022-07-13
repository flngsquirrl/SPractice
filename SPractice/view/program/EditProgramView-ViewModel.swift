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
            editMode.isEditing || !ValidationService.isValid(template)
        }
    }
}
