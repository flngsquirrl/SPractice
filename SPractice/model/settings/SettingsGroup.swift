//
//  SettingsGroup.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.07.22.
//

import Foundation

enum SettingsGroup: String, CaseIterable, Codable {
    case exercise = "Exercise"
    case practice = "Practice"
    case templates = "Templates"
    
    static let hierarchy: [SettingsGroup: [SettingsSubGroup]] = [
        .exercise: [.tabata],
        .practice: [.rest, .flow],
        .templates: [.examples]
    ]
}

enum SettingsSubGroup: String, CaseIterable, Codable {
    case tabata = "Tabata"
    case flow = "Flow"
    case rest = "Rest"
    case examples = "Examples"
}
