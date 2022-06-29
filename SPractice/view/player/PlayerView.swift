//
//  PlayerView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PlayerButton: View {
    let systemImageName: String
    let onClick: (() -> Void)?
    let isEnabled: Bool
    
    private let mainFont: Font = .title.weight(.semibold)
    private let noteFont: Font = .body.weight(.semibold)
    
    var body: some View {
        VStack {
            Button() { onClick?() }
            label: {
                Image(systemName: systemImageName)
                    .frame(width: 97, height: 70)
                    .font(mainFont)
                    .foregroundColor(.creamy)
                    .background(.lightOrange)
                    .opacity(isEnabled ? 1 : 0.6)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(3)
            .disabled(!isEnabled)
        }
    }
}

struct PlayerView: View {
    
    @ObservedObject private var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    var body: some View {
        VStack {
            HStack {
                PlayerButton(systemImageName: "backward.frame.fill", onClick: player.backwardClicked, isEnabled: player.isBackwardEnabled)
                    .animation(.default, value: player.isBackwardEnabled)
                
                if (player.isPlaying) {
                    PlayerButton(systemImageName: "pause.fill", onClick: player.pauseClicked, isEnabled: player.isPauseEnabled)
                        .animation(.default, value: player.isPauseEnabled)
                } else {
                    PlayerButton(systemImageName: "play.fill", onClick: player.playClicked, isEnabled: player.isPlayEnabled)
                        .animation(.default, value: player.isPlayEnabled)
                }
                
                PlayerButton(systemImageName: "forward.frame.fill", onClick: player.forwardClicked, isEnabled: player.isForwardEnabled)
                    .animation(.default, value: player.isForwardEnabled)
            }
            PlayerButton(systemImageName: "stop.fill", onClick: player.stopClicked, isEnabled: player.isStopEnabled)
                .animation(.default, value: player.isStopEnabled)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black)
                        .frame(width: 320, height: 200)
                    
                    PlayerView(player: Player())
                }
                
                Spacer()
            }
        }
    }
}
