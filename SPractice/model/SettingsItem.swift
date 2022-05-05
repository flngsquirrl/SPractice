//
//  SettingsItem.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.05.22.
//

import Foundation

struct SettingsItem: Codable, Equatable {
    
    let type: SettingsItemType
    var value: Int
    
    init(type: SettingsItemType, value: Int) {
        self.type = type
        self.value = value
    }

}
