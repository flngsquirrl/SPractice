//
//  WelcomeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.07.22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color.lightOrange
            VStack {
                SquirrelInWheelLogo()
                    .frame(width: 300, height: 300)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
