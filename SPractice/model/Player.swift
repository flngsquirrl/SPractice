//
//  Player.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.05.22.
//

import Foundation

class Player: ObservableObject {
    
    @Published var isPlaying = false
    
    @Published var isBackwardEnabled = false
    @Published var isForwardEnabled = false
    @Published var isPlayEnabled = true
    @Published var isPauseEnabled = false
    @Published var isStopEnabled = false
    
}
