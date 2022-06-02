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
                    //.padding(12)
                    .frame(width: 97, height: 80)
                    .font(mainFont)
                    .foregroundColor(isEnabled ? .creamy : .gray)
                    .background(.lightNavy)
                    //.clipShape(RoundedRectangle(cornerRadius: 12))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .shadow(color: .white, radius: 3)
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
                PlayerButton(systemImageName: "backward.fill", onClick: player.backwardClicked, isEnabled: player.isBackwardEnabled)
                
                if (player.isPlaying) {
                    PlayerButton(systemImageName: "pause.fill", onClick: player.pauseClicked, isEnabled: player.isPauseEnabled)
                } else {
                    PlayerButton(systemImageName: "play.fill", onClick: player.playClicked, isEnabled: player.isPlayEnabled)
                }
                PlayerButton(systemImageName: "forward.fill", onClick: player.forwardClicked, isEnabled: player.isForwardEnabled)
            }
            PlayerButton(systemImageName: "stop.fill", onClick: player.stopClicked, isEnabled: player.isStopEnabled)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .lightNavy, location: 0.3),
                .init(color: .creamy, location: 1),
            ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.lightNavy)
                        .frame(width: 320, height: 200)
                    
                    PlayerView(player: Player())
                }
                
                Spacer()
            }
        }
    }
}
