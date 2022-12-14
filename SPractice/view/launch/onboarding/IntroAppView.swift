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

                Spacer()
                LayoutUtils.getLogo(parentContainerSize: geo.size)
                ForEach(1..<5, id: \.self) { _ in
                    Spacer()
                }
            }
        }
    }
}

struct IntroAppView_Previews: PreviewProvider {
    static var previews: some View {
        IntroAppView()
            .foregroundColor(.mainColor)
    }
}
