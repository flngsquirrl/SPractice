//
//  StabView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 9.07.22.
//

import SwiftUI

struct StabView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(uiColor: .secondarySystemBackground)
                VStack {
                    let size = LayoutUtils.getPreferredLogoSize(parentContainerSize: geo.size)
                    LayoutUtils.getLogo()
                        .frame(width: size, height: size)
                }
            }
        }
    }
}

struct StabView_Previews: PreviewProvider {
    static var previews: some View {
        StabView()
    }
}
