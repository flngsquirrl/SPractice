//
//  AudioPlayer.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.09.22.
//

import Foundation

protocol AudioPlayer {
    func play(type: SoundType)
    func prepareToPlay(type: SoundType)
}
