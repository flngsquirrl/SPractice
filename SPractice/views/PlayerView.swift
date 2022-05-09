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
    
    @State var disabled: Bool = false
    
    private let mainFont: Font = .title.weight(.semibold)
    private let noteFont: Font = .body.weight(.semibold)
    
    var body: some View {
        VStack {
            Button() { onClick() }
            label: {
                Image(systemName: systemImageName)
            }
            .disabled(disabled)
            .padding(10)
            .frame(width: 90, height: 60)
            .font(mainFont)
            .foregroundColor(disabled ? .gray : .lightForeground)
            .background(.darkBackground)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    func disable() {
        disabled = true
    }
    
    func enable() {
        disabled = false
    }
}

struct PlayerView: View {
    
    @State private var isPlaying = false
    
    var backwardClicked: () -> Void = {}
    var playClicked: () -> Void = {}
    var pauseClicked: () -> Void = {}
    var forwardClicked: () -> Void = {}
    var finishClicked: () -> Void = {}
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.lightForeground)
                .frame(width: 320, height: 160)
            
            VStack {
                HStack {
                    PlayerButton(systemImageName: "backward.fill") {
                        backwardClicked()
                    }
                    if (isPlaying) {
                        PlayerButton(systemImageName: "pause.fill") {
                            isPlaying.toggle()
                            pauseClicked()
                        }
                    } else {
                        PlayerButton(systemImageName: "play.fill") {
                            isPlaying.toggle()
                            playClicked()
                        }
                    }
                    PlayerButton(systemImageName: "forward.fill") {
                        forwardClicked()
                    }
                }
                PlayerButton(systemImageName: "stop.fill") {
                    finishClicked()
                }
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightBright
                .ignoresSafeArea()
            PlayerView()
        }
    }
}
