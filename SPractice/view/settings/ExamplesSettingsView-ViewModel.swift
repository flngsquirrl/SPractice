//
//  ExamplesSettingsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.08.22.
//

import Foundation

extension ExamplesSettingsView {
    @MainActor class ViewModel: ObservableObject {

        @Published var restoreGroup: RestoreGroup = .all

        var exerciseExamplesManager = ExerciseExamplesManager()
        var programExamplesManager = ProgramExamplesManager()

        static let defaultResetText = "Reset modified examples to defaults"
        static let programsDetailsText = "Programs: "
        static let exercisesDetailsText = "Exercises: "

        static let defaultRestoreText = "Recreate deleted examples"

        var modifiedPrograms: [String] {
            programExamplesManager.modifiedExamplesNames
        }

        var modifiedExercises: [String] {
            exerciseExamplesManager.modifiedExamplesNames
        }

        var deletedPrograms: [String] {
            programExamplesManager.deletedExamplesNames
        }

        var deletedExercises: [String] {
            exerciseExamplesManager.deletedExamplesNames
        }

        var resetFooterText: String {
            switch restoreGroup {
            case .all:
                return allModifiedFooterText
            case .programs:
                return programsModifiedFooterText
            case .exercises:
                return exercisesModifiedFooterText
            }
        }

        var exercisesModifiedFooterText: String {
            if hasModifiedExercises {
                return "\(Self.defaultResetText)\n\(Self.exercisesDetailsText)\(modifiedExercises.joined(separator: ", "))"
            } else {
                return Self.defaultResetText
            }
        }

        var programsModifiedFooterText: String {
            if hasModifiedPrograms {
                return "\(Self.defaultResetText)\n\(Self.programsDetailsText)\(modifiedPrograms.joined(separator: ", "))"
            } else {
                return Self.defaultResetText
            }
        }

        var allModifiedFooterText: String {
            if hasModifiedPrograms && !hasModifiedExercises {
                return "\(Self.defaultResetText)\n\(Self.programsDetailsText)\(modifiedPrograms.joined(separator: ", "))"
            } else if !hasModifiedPrograms && hasModifiedExercises {
                return "\(Self.defaultResetText)\n\(Self.exercisesDetailsText)\(modifiedExercises.joined(separator: ", "))"
            } else if hasModifiedItems {
                return """
                \(Self.defaultResetText)
                \(Self.programsDetailsText)\(modifiedPrograms.joined(separator: ", "))
                \(Self.exercisesDetailsText)\(modifiedExercises.joined(separator: ", "))
                """
            } else {
                return Self.defaultResetText
            }
        }

        var hasModifiedItems: Bool {
            switch restoreGroup {
            case .all:
                return hasModifiedPrograms || hasModifiedExercises
            case .programs:
                return hasModifiedPrograms
            case .exercises:
                return hasModifiedExercises
            }
        }

        var hasModifiedPrograms: Bool {
            programExamplesManager.areAnyExamplesModified()
        }

        var hasModifiedExercises: Bool {
            exerciseExamplesManager.areAnyExamplesModified()
        }

        var exercisesDeletedFooterText: String {
            if hasDeletedExercises {
                return "\(Self.defaultRestoreText)\n\(Self.exercisesDetailsText)\(deletedExercises.joined(separator: ", "))"
            } else {
                return Self.defaultRestoreText
            }
        }

        var programsDeletedFooterText: String {
            if hasDeletedPrograms {
                return "\(Self.defaultRestoreText)\n\(Self.programsDetailsText)\(deletedPrograms.joined(separator: ", "))"
            } else {
                return Self.defaultRestoreText
            }
        }

        var allDeletedFooterText: String {
            if hasDeletedPrograms && !hasDeletedExercises {
                return "\(Self.defaultRestoreText)\n\(Self.programsDetailsText)\(deletedPrograms.joined(separator: ", "))"
            } else if !hasDeletedPrograms && hasDeletedExercises {
                return "\(Self.defaultRestoreText)\n\(Self.exercisesDetailsText)\(deletedExercises.joined(separator: ", "))"
            } else if hasDeletedItems {
                return """
                \(Self.defaultRestoreText)
                \(Self.programsDetailsText)\(deletedPrograms.joined(separator: ", "))
                \(Self.exercisesDetailsText)\(deletedExercises.joined(separator: ", "))
                """
            } else {
                return Self.defaultRestoreText
            }
        }

        var restoreFooterText: String {
            switch restoreGroup {
            case .all:
                return allDeletedFooterText
            case .programs:
                return programsDeletedFooterText
            case .exercises:
                return exercisesDeletedFooterText
            }
        }

        var hasDeletedItems: Bool {
            switch restoreGroup {
            case .all:
                return hasDeletedPrograms || hasDeletedExercises
            case .programs:
                return hasDeletedPrograms
            case .exercises:
                return hasDeletedExercises
            }
        }

        var hasDeletedPrograms: Bool {
            programExamplesManager.areAnyExamplesDeleted()
        }

        var hasDeletedExercises: Bool {
            exerciseExamplesManager.areAnyExamplesDeleted()
        }

        func resetModified() {
            switch restoreGroup {
            case .all:
                programExamplesManager.resetModifiedExamples()
                exerciseExamplesManager.resetModifiedExamples()
            case .programs:
                programExamplesManager.resetModifiedExamples()
                return
            case .exercises:
                exerciseExamplesManager.resetModifiedExamples()
                return
            }
        }

        func restoreDeleted() {
            switch restoreGroup {
            case .all:
                programExamplesManager.restoreDeletedExamples()
                exerciseExamplesManager.restoreDeletedExamples()
            case .programs:
                programExamplesManager.restoreDeletedExamples()
            case .exercises:
                exerciseExamplesManager.restoreDeletedExamples()
            }
        }
    }
}
