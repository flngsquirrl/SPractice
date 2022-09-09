//
//  Text-IntroTitle.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.09.22.
//

import SwiftUI

extension Text {

    func introTitle(geo: GeometryProxy) -> some View {
        self
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: geo.size.width, height: geo.size.height * 0.2, alignment: .bottom)
    }

}
