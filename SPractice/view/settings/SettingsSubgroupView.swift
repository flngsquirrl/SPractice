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
        NavigationStack {
            SettingsSubgroupDetailsView(subgroup: subgroup)
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

struct SettingsSubgroupView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSubgroupView(subgroup: .rest)
    }
}
