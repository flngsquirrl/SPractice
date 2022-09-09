//
//  PlayerView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PlayerButton: View {
    let systemImageName: String
    let isEnabled: Bool
    let width: CGFloat

    let onClick: (() -> Void)?

    private let mainFont: Font = .title.weight(.semibold)
    private let noteFont: Font = .body.weight(.semibold)

    var body: some View {
        VStack {
            Button { onClick?() }
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
            let width = max(geo.size.width - 20, 0) * 0.33
            
            VStack {
                HStack(spacing: 0) {
                    PlayerButton(systemImageName: "backward.frame.fill", isEnabled: player.isBackwardEnabled, width: width) {
                        player.backwardClicked()
                    }
                    .animation(.default, value: player.isBackwardEnabled)

                    Group {
                        if player.isPlaying {
                            PlayerButton(systemImageName: "pause.fill", isEnabled: player.isPauseEnabled, width: width) {
                                player.pauseClicked()
                            }
                            .animation(.default, value: player.isPauseEnabled)
                        } else {
                            PlayerButton(systemImageName: "play.fill", isEnabled: player.isPlayEnabled, width: width) {
                                player.playClicked()
                            }
                            .animation(.default, value: player.isPlayEnabled)
                        }
                    }
                    .padding([.leading, .trailing], 10)

                    PlayerButton(systemImageName: "forward.frame.fill", isEnabled: player.isForwardEnabled, width: width) {
                        player.forwardClicked()
                    }
                    .animation(.default, value: player.isForwardEnabled)
                }
            }
            .frame(width: geo.size.width)
        }
        .frame(height: 70)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black)
                .frame(width: geo.size.width * 0.8, height: 70)

            PlayerView(player: Player())
                .frame(width: geo.size.width * 0.8, height: 70)
        }
    }
}
