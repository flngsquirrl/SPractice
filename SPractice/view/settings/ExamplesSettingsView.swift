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
        Section {
            Picker("Templates for", selection: $restoreGroup) {
                ForEach(RestoreGroup.allCases, id: \.self) { group in
                    Text(group.rawValue)
                }
            }
            Button("Restore") {
                
            }
        } footer: {
            Text("Deleted example templates will be restored")
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
