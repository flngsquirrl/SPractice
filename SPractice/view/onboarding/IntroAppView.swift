//
//  IntroAppView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.09.22.
//

import SwiftUI

struct IntroAppView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Just keep practicing")
                    .introTitle(geo: geo)

                let size = LayoutUtils.getPreferredLogoSize(parentContainerSize: geo.size)
                LayoutUtils.logo
                    .frame(width: size, height: size)
                    .padding()
            }
        }
    }
}

struct IntroAppView_Previews: PreviewProvider {
    static var previews: some View {
        IntroAppView()
            .foregroundColor(.lightOrange)
    }
}
