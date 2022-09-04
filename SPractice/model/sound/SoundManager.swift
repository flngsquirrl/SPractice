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

    private let basicPlayer = BasicAudioPlayer()

    var player: AudioPlayer {
        return basicPlayer
    }

}
