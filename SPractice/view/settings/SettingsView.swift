//
//  SettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct SettingsView: View {

    @State private var selection: SettingsSubGroup?

    var body: some View {
        NavigationSplitView {
            List(SettingsGroup.allCases, id: \.self, selection: $selection) { group in
                Section {
                    let subgroups = SettingsGroup.hierarchy[group]!
                    ForEach(subgroups, id: \.self) { subgroup in
                        NavigationLink(subgroup.rawValue, value: subgroup)
                    }
                } header: {
                    Text(group.rawValue)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
        } detail: {
            if let selection = selection {
                SettingsSubgroupDetailsView(subgroup: selection)
            } else {
                StabView()
            }
        }
        .navigationSplitViewStyle(.balanced)
        .accentColor(.customAccentColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
