//
//  SettingsLink.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.07.22.
//

import SwiftUI

struct SettingsLink: View {
    var text: String
    
    @Binding var showSettings: Bool
    
    static let settingsText = Text("Settings").foregroundColor(.customAccentColor)
    
    var body: some View {
        content
            .onTapGesture {
                showSettings = true
            }
    }
    
    var content: some View {
        Group {
            Text(text.trim() + " ") +
            Self.settingsText
        }
    }
}

struct SettingsLink_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLink(text: "Link to", showSettings: .constant(.random()))
    }
}
