//
//  SettingsGroup.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.07.22.
//

import Foundation

enum SettingsGroup: String, CaseIterable, Codable  {
    case exercises = "Exercises"
    case templates = "Templates"
    
    static let hierarchy: [SettingsGroup: [SettingsSubGroup]] = [
        .exercises: [.tabata, .flow, .pause],
        .templates: [.examples]
    ]
}

enum SettingsSubGroup: String, CaseIterable, Codable {
    case tabata = "Tabata"
    case flow = "Flow"
    case pause = "Pause"
    case examples = "Examples"
}
