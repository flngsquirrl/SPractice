//
//  BasicAudioPlayer.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.09.22.
//

import AVFoundation
import Foundation

class BasicAudioPlayer: AudioPlayer {

    var preparedType: SoundType?
    var audioPlayer: AVAudioPlayer?

    static let soundType = "wav"

    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up AVAudioSession.")
        }
    }

    func prepareToPlay(type: SoundType) {
        let path = Bundle.main.path(forResource: type.rawValue, ofType: Self.soundType)
        guard let path = path else {
            print("Sound file is not found: " + type.rawValue + ".\(Self.soundType))")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            preparedType = type
        } catch {
            print("Failed to set up AVAudioPlayer.")
        }
    }

    func play(type: SoundType) {
        if preparedType != type {
            prepareToPlay(type: type)
        }
        play()
    }

    func play() {
        audioPlayer?.play()
        preparedType = nil
    }
}
