//
//  PlayerView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PlayerButton: View {
    let systemImageName: String
    let onClick: () -> Void
    let isEnabled: Bool
    
    private let mainFont: Font = .title.weight(.semibold)
    private let noteFont: Font = .body.weight(.semibold)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.creamy)
                .frame(width: 100, height: 70)
                .shadow(color: .darkNavy, radius: 2)
                
            
            VStack {
                Button() { onClick() }
                label: {
                    Image(systemName: systemImageName)
                        .padding(10)
                        .frame(width: 94, height: 64)
                        .font(mainFont)
                        .foregroundColor(isEnabled ? .creamy : .gray)
                        .background(.lightNavy)
                        .contentShape(RoundedRectangle(cornerRadius: 5))
                }
                .disabled(!isEnabled)
                
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.darkNavy, style: StrokeStyle(lineWidth: 1)))
        }
    }
}

struct PlayerView: View {
    
    @ObservedObject private var player: Player
    
    private let backwardClicked: () -> Void
    private let playClicked: () -> Void
    private let pauseClicked: () -> Void
    private let forwardClicked: () -> Void
    private let stopClicked: () -> Void
    
    init(player: Player, playClicked: @escaping () -> Void = {}, pauseClicked: @escaping () -> Void = {}, backwardClicked: @escaping () -> Void = {}, forwardClicked: @escaping () -> Void = {}, stopClicked: @escaping () -> Void = {}) {
        self.player = player
        self.backwardClicked = backwardClicked
        self.forwardClicked = forwardClicked
        self.playClicked = playClicked
        self.pauseClicked = pauseClicked
        self.stopClicked = stopClicked
    }
    
    func onPauseClicked() {
        player.isPlaying.toggle()
        pauseClicked()
    }
    
    func onPlayClicked() {
        player.isPlaying.toggle()
        playClicked()
    }
    
    var body: some View {
        VStack {
            HStack {
                PlayerButton(systemImageName: "backward.fill", onClick: backwardClicked, isEnabled: player.isBackwardEnabled)
                
                if (player.isPlaying) {
                    PlayerButton(systemImageName: "pause.fill", onClick: onPauseClicked, isEnabled: player.isPauseEnabled)
                } else {
                    PlayerButton(systemImageName: "play.fill", onClick: onPlayClicked, isEnabled: player.isPlayEnabled)
                }
                PlayerButton(systemImageName: "forward.fill", onClick: forwardClicked, isEnabled: player.isForwardEnabled)
            }
            PlayerButton(systemImageName: "stop.fill", onClick: stopClicked, isEnabled: player.isStopEnabled)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.lightOrange)
                .frame(width: 320, height: 200)
            
            PlayerView(player: Player())
        }
    }
}
