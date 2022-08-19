//
//  Player.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.05.22.
//

import Foundation
import SwiftUI

class Player: ObservableObject {
    
    @Published var isPlaying = false
    
    @Published var isBackwardEnabled = false
    @Published var isForwardEnabled = false
    @Published var isPlayEnabled = true
    @Published var isPauseEnabled = false
    
    var onBackwardClicked: (() -> Void)?
    var onPlayClicked: (() -> Void)?
    var onPauseClicked: (() -> Void)?
    var onForwardClicked: (() -> Void)?
    
    func pauseClicked() {
        withAnimation {
            isPlaying.toggle()
        }
        onPauseClicked?()
    }
    
    func playClicked() {
        withAnimation {
            isPlaying.toggle()
        }
        onPlayClicked?()
    }
    
    func backwardClicked() {
        onBackwardClicked?()
    }
    
    func forwardClicked() {
        onForwardClicked?()
    }
}
