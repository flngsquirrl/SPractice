//
//  SettingsItem.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.05.22.
//

import Foundation

class SettingsItem: ObservableObject, Codable {
    
    enum SettingsType: String, Codable {
        case tabata_warmup = "Warm up"
        case tabata_activity = "Activity"
        case tabata_rest = "Rest"
        case tabata_cooldown = "Cool down"
        case tabata_repetitions = "Number of repetitions"
        case general_rest = "Duration"
        
        static let tabata_interval_sequence: [SettingsType] = [.tabata_warmup, .tabata_activity, .tabata_rest, .tabata_cooldown]
    }
    
    enum CodingKeys: CodingKey {
        case type
        case value
    }
    
    let type: SettingsType
    @Published var value: Int
    
    init(type: SettingsType, value: Int) {
        self.type = type
        self.value = value
    }
    
    convenience init(from item: SettingsItem) {
        self.init(type: item.type, value: item.value)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(SettingsType.self, forKey: .type)
        value = try container.decode(Int.self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(value, forKey: .value)
    }
}
