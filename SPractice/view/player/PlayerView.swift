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
    
    let width: CGFloat
    
    private let mainFont: Font = .title.weight(.semibold)
    private let noteFont: Font = .body.weight(.semibold)
    
    var body: some View {
        VStack {
            Button() { onClick?() }
            label: {
                Image(systemName: systemImageName)
                    .frame(width: width, height: 70)
                    .font(mainFont)
                    .foregroundColor(.creamy)
                    .background(.lightOrange)
                    .opacity(isEnabled ? 1 : 0.6)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
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
        GeometryReader { geo in
            let width = (geo.size.width - 20) * 0.315
            
            VStack {
                HStack {
                    PlayerButton(systemImageName: "backward.frame.fill", onClick: player.backwardClicked, isEnabled: player.isBackwardEnabled, width: width)
                        .animation(.default, value: player.isBackwardEnabled)
                    
                    Group {
                        if (player.isPlaying) {
                            PlayerButton(systemImageName: "pause.fill", onClick: player.pauseClicked, isEnabled: player.isPauseEnabled, width: width)
                                .animation(.default, value: player.isPauseEnabled)
                        } else {
                            PlayerButton(systemImageName: "play.fill", onClick: player.playClicked, isEnabled: player.isPlayEnabled, width: width)
                                .animation(.default, value: player.isPlayEnabled)
                        }
                    }
                    .padding([.leading, .trailing], 10)
                    
                    PlayerButton(systemImageName: "forward.frame.fill", onClick: player.forwardClicked, isEnabled: player.isForwardEnabled, width: width)
                        .animation(.default, value: player.isForwardEnabled)
                }
                .padding([.bottom], 10)
                
                PlayerButton(systemImageName: "stop.fill", onClick: player.stopClicked, isEnabled: player.isStopEnabled, width: width)
                    .animation(.default, value: player.isStopEnabled)
            }
            .frame(width: geo.size.width)
        }
        .frame(height: 160)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black)
                .frame(width: geo.size.width * 0.8, height: 160)
            
            PlayerView(player: Player())
                .frame(width: geo.size.width * 0.8, height: 160)
        }
    }
}
