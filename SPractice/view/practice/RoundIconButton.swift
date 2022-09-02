//
//  RoundIconButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.07.22.
//

import SwiftUI

struct RoundIconButton: View {

    var imageName: String
    var disabled: Bool
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .fill(disabled ? Color(UIColor.systemGray) : .lightOrange)
                    .opacity(disabled ? 0.6 : 1)
                    .frame(width: 35, height: 35)

                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                    .font(.title.bold())
                    .frame(width: 27, height: 27)
                    .clipShape(Circle())
            }
        }
        .disabled(disabled)
    }
}

struct RoundIconButton_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RoundIconButton(imageName: "arrow.clockwise.circle.fill", disabled: false, action: {})
            RoundIconButton(imageName: "arrow.clockwise.circle.fill", disabled: true, action: {})

            RoundIconButton(imageName: "info.circle.fill", disabled: false, action: {})
            RoundIconButton(imageName: "info.circle.fill", disabled: true, action: {})
        }
    }
}
