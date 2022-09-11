//
//  InfoButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.07.22.
//

import SwiftUI

struct InfoButton: View {

    var isFooter: Bool = false

    var body: some View {
        Button {

        } label: {
            Image(systemName: "info.circle")
        }
        .font(isFooter ? .footnote : nil)
    }
}

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton()
    }
}
