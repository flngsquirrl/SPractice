//
//  Player.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.05.22.
//

import Foundation
import SwiftUI

@MainActor class Player: ObservableObject {
    
    @Published var isPlaying = false
    
    @Published var isBackwardEnabled = false
    @Published var isForwardEnabled = false
    @Published var isPlayEnabled = true
    @Published var isPauseEnabled = false
    
    var onBackwardClicked: (@MainActor () -> Void)?
    var onPlayClicked: (@MainActor () -> Void)?
    var onPauseClicked: (@MainActor () -> Void)?
    var onForwardClicked: (@MainActor () -> Void)?
    
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
