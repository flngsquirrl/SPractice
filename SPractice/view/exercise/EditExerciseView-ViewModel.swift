//
//  EditExerciseView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

extension EditExerciseView {
    @MainActor class ViewModel: ObservableObject {

        var template: ExerciseTemplate
        @Published var editorTemplate: ExerciseEditor.EditorTemplate

        var examplesManager = ExerciseExamplesManager()
        let exerciseValidator = ExerciseValidator()

        init(template: ExerciseTemplate) {
            self.template = template
            self.editorTemplate = ExerciseEditor.EditorTemplate(from: template)
        }

        var templateToSave: ExerciseTemplate {
            template.update(from: ExerciseTemplate(from: editorTemplate))
            return template
        }

        var isSaveDisabled: Bool {
            !exerciseValidator.isValid(templateToSave)
        }

        var showExampleUpdateConfirmation: Bool {
            let exerciseTemplate = templateToSave
            if exerciseTemplate.isExample {
                let example = examplesManager.getExample(exampleId: exerciseTemplate.exampleId!)
                if let example = example {
                    if !exerciseTemplate.isEqualToExample(example: example) {
                        return true
                    }
                }
            }

            return false
        }

        func prepareTemplate(markAsNonExample: Bool) -> ExerciseTemplate {
            var exerciseTemplate = templateToSave
            if markAsNonExample {
                exerciseTemplate.isExample = false
            }
            return exerciseTemplate
        }
    }
}
