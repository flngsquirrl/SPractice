//
//  RestoreDefaultsButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.07.22.
//

import SwiftUI

struct RestoreDefaultsButton: View {
    
    var subgroup: SettingsSubGroup

    @State private var showResetConfirmation: Bool = false
    @Binding var areDefaultsRestored: Bool
    
    var body: some View {
        Button("Restore defaults", role: .destructive) {
            showResetConfirmation = true
        }
        .disabled(isResetDisabled)
        .alert(LayoutUtils.warningAlertTitle, isPresented: $showResetConfirmation) {
            Button("Reset", role: .destructive) {
                withAnimation {
                    SettingsManager.resetToDefauls(subgroup: subgroup)
                    areDefaultsRestored = true
                }
            }
            
            Button("Cancel", role: .cancel) {}
        } message: {
            SettingsConstants.restoreMessage
        }
        .onAppear() {
            areDefaultsRestored = false
        }
    }
    
    var isResetDisabled: Bool {
        !SettingsManager.hasChangesFromDefaults(in: subgroup)
    }
}

struct RestoreDefaultsButton_Previews: PreviewProvider {
    static var previews: some View {
        RestoreDefaultsButton(subgroup: .tabata, areDefaultsRestored: .constant(.random()))
    }
}
