//
//  Intensity.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

enum Intensity: String, Codable {
    case activity
    case rest
    case mixed

    static let managedIntensities: [Intensity] = [.activity, .rest]
}
