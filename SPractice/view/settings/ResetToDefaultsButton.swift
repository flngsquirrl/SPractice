//
//  ResetToDefaultsButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.07.22.
//

import SwiftUI

struct ResetToDefaultsButton: View {
    
    var subgroup: SettingsSubGroup

    @State private var showResetConfirmation: Bool = false
    @Binding var areResetToDefaults: Bool
    
    var body: some View {
        Button("Reset to defaults", role: .destructive) {
            showResetConfirmation = true
        }
        .disabled(isResetDisabled)
        .alert(LayoutUtils.warningAlertTitle, isPresented: $showResetConfirmation) {
            Button("Reset", role: .destructive) {
                withAnimation {
                    SettingsManager.resetToDefauls(subgroup: subgroup)
                    areResetToDefaults = true
                }
            }
            
            Button("Cancel", role: .cancel) {}
        } message: {
            SettingsConstants.resetMessage
        }
        .onAppear() {
            areResetToDefaults = false
        }
    }
    
    var isResetDisabled: Bool {
        !SettingsManager.hasChangesFromDefaults(in: subgroup)
    }
}

struct ResetToDefaultsButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetToDefaultsButton(subgroup: .tabata, areResetToDefaults: .constant(.random()))
    }
}
