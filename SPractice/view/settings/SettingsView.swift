//
//  SettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showResetConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(SettingsGroup.allCases, id: \.self) { group in
                    Section(group.rawValue) {
                        let subgroups = SettingsGroup.hierarchy[group]!
                        ForEach(subgroups, id: \.self) { subgroup in
                            NavigationLink {
                                SettingsSubgroupDetailsView(subgroup: subgroup)
                            } label: {
                                Text(subgroup.rawValue)
                            }
                        }
                    }
                }
                
                Button("Restore all defaults") {
                    showResetConfirmation = true
                }
            }
            .alert("Please, note", isPresented: $showResetConfirmation) {
                Button("Reset") {
                    SettingsManager.shared.resetToDefauls()
                }
                
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("These settings influence your exercises and programs")
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
