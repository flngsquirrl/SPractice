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
    @State private var restoreAllDisabled = false
    
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
                
                Button("Restore all defaults", role: .destructive) {
                    showResetConfirmation = true
                }
                .disabled(restoreAllDisabled)
            }
            .onAppear() {
                restoreAllDisabled = !SettingsManager.hasChangesFromDefaults
            }
            .alert(LayoutUtils.warningAlertTitle, isPresented: $showResetConfirmation) {
                Button("Restore", role: .destructive) {
                    SettingsManager.resetToDefauls()
                    restoreAllDisabled = true
                }
                
                Button("Cancel", role: .cancel) {}
            } message: {
                SettingsConstants.restoreMessage
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
