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
        
        static let defaultResetText = "Reset modified examples to defaults"
        static let programsDetailsText = "Programs: "
        static let exercisesDetailsText = "Exercises: "
        
        static let defaultRestoreText = "Recreate deleted examples"
        
        var modifiedPrograms: [String] {
            programsManager.modifiedExamplesNames
        }
        var modifiedExercises: [String] {
            exercisesManager.modifiedExamplesNames
        }
        var deletedPrograms: [String] {
            programsManager.deletedExamplesNames
        }
        var deletedExercises: [String] {
            exercisesManager.deletedExamplesNames
        }
        
        var programsManager: ProgramsManager {
            ProgramsManager.shared
        }
        
        var exercisesManager: ExercisesManager {
            ExercisesManager.shared
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
            programsManager.areAnyExamplesModified()
        }
        
        var hasModifiedExercises: Bool {
            exercisesManager.areAnyExamplesModified()
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
            programsManager.areAnyExamplesDeleted()
        }
        
        var hasDeletedExercises: Bool {
            exercisesManager.areAnyExamplesDeleted()
        }
        
        func resetModified() {
            switch restoreGroup {
            case .all:
                programsManager.resetModifiedExamples()
                exercisesManager.resetModifiedExamples()
            case .programs:
                programsManager.resetModifiedExamples()
                return
            case .exercises:
                exercisesManager.resetModifiedExamples()
                return
            }
        }
        
        func restoreDeleted() {
            switch restoreGroup {
            case .all:
                programsManager.restoreDeletedExamples()
                exercisesManager.restoreDeletedExamples()
            case .programs:
                programsManager.restoreDeletedExamples()
            case .exercises:
                exercisesManager.restoreDeletedExamples()
            }
        }
    }
}
