//
//  SquirrelInWheelIcon.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.09.22.
//

import SwiftUI

struct SquirrelInWheelIcon: View {

    var lineWidth: CGFloat = 5
    var color: Color = .white
    var backgroundColor: Color = .lightOrange

    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: geo.size.width * 0.2)
                    .fill(backgroundColor)

                Group {
                    SquirrelInWheelLogo(lineWidth: lineWidth, color: color)
                    .frame(width: geo.size.width * 0.75, height: geo.size.width * 0.75)
                }
                .frame(width: geo.size.width, height: geo.size.width)
            }
        }
    }
}

struct SquirrelInWheelIcon_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack {
                Color.black
                VStack {
                    SquirrelInWheelIcon()
                        .frame(width: 100, height: 100)
                }
            }
            ZStack {
                Color.white
                VStack {
                    SquirrelInWheelIcon()
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}
