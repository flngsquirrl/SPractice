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
                Color(uiColor: .secondarySystemBackground)
                    .ignoresSafeArea()
                VStack {
                    let size = LayoutUtils.getPreferredLogoSize(parentContainerSize: geo.size)
                    LayoutUtils.logo
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
