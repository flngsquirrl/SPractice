//
//  Setting.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.05.22.
//

import Foundation

enum SettingsItemType: String, Codable {
    case tabata_warmup = "Warm up"
    case tabata_activity = "Activity"
    case tabata_rest = "Rest"
    case tabata_cooldown = "Cool down"
    case tabata_repetitions = "Number of repetitions"
    case general_rest = "Duration"
    
    static let tabata_interval_sequence: [SettingsItemType] = [.tabata_warmup, .tabata_activity, .tabata_rest, .tabata_cooldown]
}
