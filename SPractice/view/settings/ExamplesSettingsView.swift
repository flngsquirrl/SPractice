//
//  ExamplesSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct ExamplesSettingsView: View {
    
    @ObservedObject var programsManager = ProgramsManager.shared
    @ObservedObject var exercisesManager = ExercisesManager.shared
    
    enum RestoreGroup: String, CaseIterable {
        case all = "all"
        case programs = "programs"
        case exercises = "exercises" 
    }
    
    @State private var restoreGroup: RestoreGroup = .all
    
    var body: some View {
        Picker("Templates for", selection: $restoreGroup) {
            ForEach(RestoreGroup.allCases, id: \.self) { group in
                Text(group.rawValue)
            }
        }
        
        Section {
            Button("Restore deleted") {
                restoreDeleted()
            }
            .disabled(isRestoreDeletedDisabled)
        } footer: {
            Text("Recreate deleted examples")
        }
        
        Section {
            Button("Reset modified", role: .destructive) {
                resetModified()
            }
            .disabled(isResetModifiedDisabled)
        } footer: {
            Text("Reset modified examples to defaults")
        }
    }
    
    var isResetModifiedDisabled: Bool {
        switch restoreGroup {
        case .all:
            return !(programsManager.areAnyExamplesModified() || exercisesManager.areAnyExamplesModified())
        case .programs:
            return !programsManager.areAnyExamplesModified()
        case .exercises:
            return !exercisesManager.areAnyExamplesModified()
        }
    }
    
    var isRestoreDeletedDisabled: Bool {
        switch restoreGroup {
        case .all:
            return !(programsManager.areAnyExamplesDeleted() || exercisesManager.areAnyExamplesDeleted())
        case .programs:
            return !programsManager.areAnyExamplesDeleted()
        case .exercises:
            return !exercisesManager.areAnyExamplesDeleted()
        }
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

struct ExamplesSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ExamplesSettingsView()
            }
        }
    }
}
