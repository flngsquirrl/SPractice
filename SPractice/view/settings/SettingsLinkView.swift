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
        Group {
            Text(trimmedText + " ") +
            Self.settingsText
        }
        .onTapGesture {
            showSettings = true
        }
        .sheet(isPresented: $showSettings) {
            SettingsSubgroupView(subgroup: settingsSubGroup)
        }
    }
    
    var trimmedText: String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLinkView(text: "To view configuration details open", settingsSubGroup: .examples)
    }
}
