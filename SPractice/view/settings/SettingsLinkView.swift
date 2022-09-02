//
//  SwiftUIView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.07.22.
//

import SwiftUI

struct SettingsLinkView: View {

    var text: String
    var settingsSubGroup: SettingsSubGroup

    @State private var showSettings = false

    static let settingsText = Text("Settings").foregroundColor(.customAccentColor)

    var body: some View {
        SettingsLink(text: text, showSettings: $showSettings)
            .sheet(isPresented: $showSettings) {
                SettingsSubgroupView(subgroup: settingsSubGroup)
            }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLinkView(text: "To view configuration details open", settingsSubGroup: .examples)
    }
}
