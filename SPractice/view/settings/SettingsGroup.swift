//
//  SettingsGroup.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.10.22.
//

import Foundation

enum SettingsGroup: String, CaseIterable, Codable {
    case general
    case exercise
    case practice
    case templates

    static let hierarchy: [SettingsGroup: [SettingsSubGroup]] = [
        .general: [.about],
        .exercise: [.tabata],
        .practice: [.rest, .flow],
        .templates: [.examples]
    ]
}

extension SettingsGroup {
    var title: String {
        rawValue.capitalized
    }
}

extension SettingsSubGroup {
    var title: String {
        rawValue.capitalized
    }
}
