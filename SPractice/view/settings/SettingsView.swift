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
    @State private var resetAllDisabled = true
    
    static private var groupFooter: [SettingsGroup: String] = [
        .exercise: "Set exercise configuration",
        .practice: "Configure practice parameters",
        .templates: "Manage default examples"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(SettingsGroup.allCases, id: \.self) { group in
                    Section {
                        let subgroups = SettingsGroup.hierarchy[group]!
                        ForEach(subgroups, id: \.self) { subgroup in
                            NavigationLink {
                                SettingsSubgroupDetailsView(subgroup: subgroup)
                            } label: {
                                Text(subgroup.rawValue)
                            }
                        }
                    } header: {
                        Text(group.rawValue)
                    } footer: {
                        Text(Self.groupFooter[group] ?? "")
                    }
                }
                
                Section {
                    Button("Reset all to defaults", role: .destructive) {
                        showResetConfirmation = true
                    }
                    .disabled(resetAllDisabled)
                } footer: {
                    Text("Undo all custom settings and reset example templates to the initial state")
                }
            }
            .listStyle(.insetGrouped)
            .onAppear() {
                updateResetAllDisabled()
            }
            .onDisappear() {
                SettingsManager.saveSettings()
            }
            .alert(LayoutUtils.warningAlertTitle, isPresented: $showResetConfirmation) {
                Button("Reset", role: .destructive) {
                    SettingsManager.resetToDefauls()
                    resetAllDisabled = true
                }
                
                Button("Cancel", role: .cancel) {}
            } message: {
                SettingsConstants.resetMessage
            }
            .navigationTitle("Settings")
        }
        .accentColor(.customAccentColor)
    }
    
    func updateResetAllDisabled() {
        resetAllDisabled = !SettingsManager.hasChangesFromDefaults
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
