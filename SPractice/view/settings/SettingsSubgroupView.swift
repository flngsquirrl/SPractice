//
//  SettingsSubgroupView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.07.22.
//

import SwiftUI

struct SettingsSubgroupView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var subgroup: SettingsSubGroup
    
    var body: some View {
        NavigationView {
            SettingsSubgroupDetailsView(subgroup: subgroup)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
        }
        .accentColor(.customAccentColor)
    }
}

struct SettingsSubgroupView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSubgroupView(subgroup: .pause)
    }
}