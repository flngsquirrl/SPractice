//
//  ExamplesSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct ExamplesSettingsView: View {
    
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
        } footer: {
            Text("Recreate deleted examples")
        }
        
        Section {
            Button("Reset modified", role: .destructive) {
            }
        } footer: {
            Text("Reset modified examples to defaults")
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
