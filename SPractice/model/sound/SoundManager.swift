//
//  SoundManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.08.22.
//

import AVFoundation
import Foundation

class SoundManager {

    static let shared = SoundManager()

    private init() {}

    func playSound(type: SoundType) {
        AudioServicesPlaySystemSound(type.rawValue)
    }
}
