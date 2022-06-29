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
    @Published var isStopEnabled = false
    
    var onBackwardClicked: (() -> Void)? = nil
    var onPlayClicked: (() -> Void)? = nil
    var onPauseClicked: (() -> Void)? = nil
    var onForwardClicked: (() -> Void)? = nil
    var onStopClicked: (() -> Void)? = nil
    
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
    
    func stopClicked() {
        onStopClicked?()
    }
}
