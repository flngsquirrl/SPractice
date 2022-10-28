//
//  SettingsItemHolder.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.10.22.
//

import Foundation

class SettingsItemHolder: ObservableObject {

    var settingsItem: SettingsItem {
        willSet {
            objectWillChange.send()
        }
    }

    init(_ settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
    }
}
