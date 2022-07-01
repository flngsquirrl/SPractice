//
//  Duration.swift
//  SPractice
//
//  Created by Yuliya Charniak on 1.07.22.
//

import Foundation

enum Duration: Codable, Hashable {
    case known(Int)
    case unknown
    case unlimited
}
