//
//  ResetToDefaultsButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.07.22.
//

import SwiftUI

struct ResetToDefaultsButton: View {

    @EnvironmentObject var manager: SettingsManager

    var subgroup: SettingsSubGroup

    @State private var showResetConfirmation: Bool = false

    var body: some View {
        Button("Reset to defaults", role: .destructive) {
            showResetConfirmation = true
        }
        .disabled(isResetDisabled)
        .alert(SettingsConstants.resetTitle, isPresented: $showResetConfirmation) {
            Button("Reset", role: .destructive) {
                withAnimation {
                    manager.resetToDefauls(subgroup: subgroup)
                }
            }

            Button("Cancel", role: .cancel) {}
        }
    }

    var isResetDisabled: Bool {
        !manager.hasChangesFromDefaults(in: subgroup)
    }
}

struct ResetToDefaultsButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetToDefaultsButton(subgroup: .tabata)
            .environmentObject(SettingsManager())
    }
}
