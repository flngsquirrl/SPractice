//
//  WelcomeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.07.22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.lightOrange
                VStack {
                    let size = min(geo.size.width, geo.size.height) * 0.5
                    SquirrelInWheelLogo()
                        .frame(width: size, height: size)
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
