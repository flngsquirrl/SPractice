//
//  SquirrelInWheelLogo.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import SwiftUI

struct SquirrelInWheelLogo: View {
    
    var color: Color = .white
    var gragient = LinearGradient(gradient: Gradient(stops: [
        .init(color: .lightOrange, location: 0),
        .init(color: .darkOrange, location: 1),
    ]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        GeometryReader { geo in
            let lineWidth = geo.size.width * 0.03
            let strokeStyle = StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
            
            ZStack {
                RoundedRectangle(cornerRadius: geo.size.width * 0.2)
                    .fill(color)
                
                Group {
                    Circle()
                        .fill(gragient)
                    
                    Group {
                        SquirrelInWheel()
                            .stroke(color, style: strokeStyle)
                    
                        RightWing()
                            .fill(color)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: geo.size.width * 0.7, height: geo.size.width * 0.7)
                }
                .frame(width: geo.size.width * 0.9, height: geo.size.width * 0.9)
            }
        }
    }
}

struct WingShape_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            VStack {
                SquirrelInWheelLogo()
                    .frame(width: 400, height: 400)
            }
        }
    }
}
