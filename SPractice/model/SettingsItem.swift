//
//  SettingsItem.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.05.22.
//

import Foundation

class SettingsItem: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type
        case value
        case enabled
    }
    
    let type: SettingsItemType
    @Published var value: Int
    @Published var enabled: Bool
    
    init(type: SettingsItemType, value: Int, enabled: Bool = true) {
        self.type = type
        self.value = value
        self.enabled = enabled
    }
    
    convenience init(from item: SettingsItem) {
        self.init(type: item.type, value: item.value, enabled: item.enabled)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(SettingsItemType.self, forKey: .type)
        value = try container.decode(Int.self, forKey: .value)
        enabled = try container.decode(Bool.self, forKey: .enabled)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(value, forKey: .value)
        try container.encode(enabled, forKey: .enabled)
    }
}
