//
//  BasicAudioPlayer.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.09.22.
//

import AVFoundation
import Foundation

class BasicAudioPlayer: AudioPlayer {

    var audioPlayer: AVAudioPlayer?

    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up AVAudioSession.")
        }
    }

    func play(type: SoundType) {
        let path = Bundle.main.path(forResource: type.rawValue, ofType: "wav")
        guard let path = path else {
            print("Sound file is not found: " + type.rawValue + ".wav")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to set up AVAudioPlayer.")
        }
    }
}
