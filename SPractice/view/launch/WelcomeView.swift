//
//  WelcomeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.09.22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.lightOrange
                    .ignoresSafeArea()

                VStack {
                    let size = LayoutUtils.getPreferredLogoSize(parentContainerSize: geo.size)
                    LayoutUtils.getLogo(of: .white)
                        .frame(width: size, height: size)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .drawingGroup()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
