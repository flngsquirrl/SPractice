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
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.creamy)
                .frame(width: 100, height: 70)
                .shadow(color: .darkNavy, radius: 2)
                
            
            VStack {
                Button() { onClick() }
                label: {
                    Image(systemName: systemImageName)
                }
                .disabled(disabled)
                .padding(10)
                .frame(width: 94, height: 64)
                .font(mainFont)
                .foregroundColor(disabled ? .gray : .creamy)
                .background(.lightNavy)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.darkNavy, style: StrokeStyle(lineWidth: 1)))
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

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.lightOrange)
                .frame(width: 320, height: 200)
            
            PlayerView()
        }
    }
}
