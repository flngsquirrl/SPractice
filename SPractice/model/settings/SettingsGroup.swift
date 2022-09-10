//
//  SettingsGroup.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.07.22.
//

import Foundation

enum SettingsGroup: String, CaseIterable, Codable {
    case general = "General"
    case exercise = "Exercise"
    case practice = "Practice"
    case templates = "Templates"

    static let hierarchy: [SettingsGroup: [SettingsSubGroup]] = [
        .general: [.about],
        .exercise: [.tabata],
        .practice: [.rest, .flow],
        .templates: [.examples]
    ]
}

enum SettingsSubGroup: String, CaseIterable, Codable {
    case about = "About"
    case tabata = "Tabata"
    case flow = "Flow"
    case rest = "Rest"
    case examples = "Examples"
}
