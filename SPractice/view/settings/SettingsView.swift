//
//  SettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct SettingsView: View {

    static private var groupFooter: [SettingsGroup: String] = [
        .exercise: "Set exercise configuration",
        .practice: "Configure practice parameters",
        .templates: "Manage default examples"
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        AboutSettingsView()
                    } label: {
                        Text("About")
                    }
                } header: {
                    Text("General")
                }

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
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")

            StabView()
        }
        .accentColor(.customAccentColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
