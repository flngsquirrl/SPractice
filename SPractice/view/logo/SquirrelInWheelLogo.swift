//
//  SquirrelInWheelLogo.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import SwiftUI

struct SquirrelInWheelLogo: View {

    var lineWidth: CGFloat = 1
    var color: Color = .textColor
    var withFilledWing = true

    var body: some View {
        let strokeStyle = StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                ZStack {
                    SquirrelInWheel()
                        .stroke(color, style: strokeStyle)

                    if withFilledWing {
                        RightWing()
                            .fill(color)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    }
                }
        }
}

struct SquirrelInWheelLogo_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack {
                Color.black
                VStack {
                    SquirrelInWheelLogo(lineWidth: 5, color: .mainColor)
                        .frame(width: 100, height: 100)
                }
            }
            ZStack {
                Color.white
                VStack {
                    SquirrelInWheelLogo(lineWidth: 5, color: .mainColor)
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}
