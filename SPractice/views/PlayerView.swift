//
//  PlayerView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PlayerButton: View {
    let isImage: Bool
    let systemImageName: String?
    let label: String?
    var note: String?
    let onClick: () -> Void
    
    @State var disabled: Bool = false
    
    init(systemImageName: String, onClick: @escaping () -> Void) {
        self.systemImageName = systemImageName
        self.isImage = true
        self.label = nil
        self.note = nil
        self.onClick = onClick
    }
    
    init(systemImageName: String, note: String, onClick: @escaping () -> Void) {
        self.systemImageName = systemImageName
        self.isImage = true
        self.note = note
        self.label = nil
        self.onClick = onClick
    }
    
    init(label: String, onClick: @escaping () -> Void) {
        self.systemImageName = nil
        self.label = label
        self.isImage = false
        self.note = nil
        self.onClick = onClick
    }
    
    var body: some View {
        VStack {
            Button() { onClick() }
            label: {
                if isImage {
                    Image(systemName: systemImageName!)
                        .font(.title.weight(.semibold))
                        .foregroundColor(disabled ? .gray : .black)
                } else {
                    Text(label!)
                        .font(.title.weight(.semibold))
                        .foregroundColor(disabled ? .gray : .black)
                }
            }
            .disabled(disabled)
            .padding(20)
            .frame(width: isImage ? 80 : nil, height: 50)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            if let note = note {
                Text("\(note)")
            }
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
                PlayerButton(systemImageName: "backward.fill", note: "previous") {
                    backwardClicked()
                }
                if (isPlaying) {
                    PlayerButton(systemImageName: "pause.fill", note: " ") {
                        isPlaying.toggle()
                        pauseClicked()
                    }
                } else {
                    PlayerButton(systemImageName: "play.fill", note: " ") {
                        isPlaying.toggle()
                        playClicked()
                    }
                }
                PlayerButton(systemImageName: "forward.fill", note: "next") {
                    forwardClicked()
                }
            }
            
            PlayerButton(label: "Finish") {
                finishClicked()
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            PlayerView()
        }
    }
}
