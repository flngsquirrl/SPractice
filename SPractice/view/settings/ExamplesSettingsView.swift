//
//  ExamplesSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct ExamplesSettingsView: View {
    
    @ObservedObject var programs = Programs.shared
    @ObservedObject var exercises = Exercises.shared
    
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
            }
            .disabled(isRestoreDeletedDisabled)
        } footer: {
            Text("Recreate deleted examples")
        }
        
        Section {
            Button("Reset modified", role: .destructive) {
            }
            .disabled(isResetModifiedDisabled)
        } footer: {
            Text("Reset modified examples to defaults")
        }
    }
    
    var isResetModifiedDisabled: Bool {
        switch restoreGroup {
        case .all:
            return !(programs.areAnyExamplesModified() || exercises.areAnyExamplesModified())
        case .programs:
            return !programs.areAnyExamplesModified()
        case .exercises:
            return !exercises.areAnyExamplesModified()
        }
    }
    
    var isRestoreDeletedDisabled: Bool {
        switch restoreGroup {
        case .all:
            return !(programs.areAnyExamplesDeleted() || exercises.areAnyExamplesDeleted())
        case .programs:
            return !programs.areAnyExamplesDeleted()
        case .exercises:
            return !exercises.areAnyExamplesDeleted()
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
